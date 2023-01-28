//
//  StorageSubscription.swift
//  treasury
//
//  Created by sugarbaron on 26.07.2021.
//

import CoreData

public extension Storage {
    
    typealias Subscriber = StorageSubscriber
    
}

public extension Storage {
    
    final class SubscriptionConfig {
        
        public let predicate: NSPredicate
        public let sort: [NSSortDescriptor]
        public let sectionNameKey: String?
        
        public init(_ predicate: NSPredicate = .init(value: true),
                    sort: [NSSortDescriptor] = [ ],
                    sectionNameKey: String? = nil) {
            self.predicate = predicate
            self.sort = sort
            self.sectionNameKey = sectionNameKey
        }
        
    }
    
}

public extension Storage {
    
    final class Updates<Subscriber:Storage.Subscriber> {
        
        internal let context: NSManagedObjectContext
        internal let config: Storage.SubscriptionConfig
        private var subscription: Subscription<Subscriber>?
        
        public init(_ context: NSManagedObjectContext, _ config: Storage.SubscriptionConfig) {
            self.context = context
            self.config = config
            self.subscription = nil
        }
        
        internal func keep(_ subscription: Subscription<Subscriber>) {
            self.subscription = subscription
        }
        
        public var updatedContent: Storage.UpdatedContent<Subscriber.Entity>? { subscription?.updatedContent }
        
    }
    
}

public protocol StorageSubscriber : AnyObject {
    
    associatedtype Entity : CoreDataConvertible
    
    func storageContentUpdated(_ updatedContent: Storage.UpdatedContent<Entity>)
    
}

public extension Storage.Subscriber {
    
     /**
      * attention! don't forget to save Storage.Updates object in client field
      * to be able to receive updates due to subscription
      */
    func subscribe(to updates: Storage.Updates<Self>) {
        let subscription: Storage.Subscription<Self> = Storage.Subscription<Self>(to: updates, self)
        updates.keep(subscription)
    }
    
}

internal extension Storage {
    
    final class Subscription<Subscriber:Storage.Subscriber> : NSObject, NSFetchedResultsControllerDelegate {
        
        internal let updatedContent: Storage.UpdatedContent<Subscriber.Entity>
        
        private let controller: NSFetchedResultsController<Subscriber.Entity.CoreDataClass>
        private weak var subscriber: Subscriber?
        
        internal init(to updates: Storage.Updates<Subscriber>, _ subscriber: Subscriber) {
            let request = NSFetchRequest<CoreDataClass>()
            request.entity = NSEntityDescription.entity(forEntityName: CoreDataClass.entityName, in: updates.context)
            request.sortDescriptors = updates.config.sort
            request.predicate = updates.config.predicate
            let controller = NSFetchedResultsController(fetchRequest: request,
                                                        managedObjectContext: updates.context,
                                                        sectionNameKeyPath: updates.config.sectionNameKey,
                                                        cacheName: nil)
            self.controller = controller
            self.updatedContent = Storage.UpdatedContent<Subscriber.Entity>(source: controller)
            self.subscriber = subscriber
            super.init()
            controller.delegate = self
            updates.context.performAndWait {
                do { try controller.performFetch() }
                catch { Log(error: "[Storage.Subscription] unable to fetch:[\(error)]") }
            }
        }
        
        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            subscriber?.storageContentUpdated(updatedContent)
        }
        
        private typealias CoreDataClass = Subscriber.Entity.CoreDataClass
        
    }
    
}
