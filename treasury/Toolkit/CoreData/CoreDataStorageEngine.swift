//
//  CoreDataStorageEngine.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import CoreData

final class CoreDataStorageEngine {
    
    let context: NSManagedObjectContext
    private let storage: NSPersistentContainer
    
    init(modelName: String, bundle: Bundle? = nil) throws {
        self.storage = try CoreDataStorageEngine.initialize(for: modelName, bundle: bundle)
        self.context = storage.newBackgroundContext()
    }

    private static func initialize(for modelName: String, bundle: Bundle? = nil) throws -> NSPersistentContainer {
        let storage: Database? = unwrap(bundle) { bundle in try? loadStorage(for: modelName, bundle: bundle) }
                                             ?? { Database(name: modelName) }()
        guard let database: Database = storage else { throw Exception("[CoreDataStorageEngine] unable to load storage") }
        database.loadPersistentStores { cause, loadError in
            if let error = loadError { Log(error: "unable to load persistent stores. error: \(error) cause: \(cause)") }
        }
        return database
    }
    
    private static func loadStorage(for modelName: String, bundle: Bundle) throws -> NSPersistentContainer {
        guard let modelURL = bundle.url(forResource: modelName, withExtension: "momd"),
              let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
        else { throw Exception("[CoreDataStorageEngine] unable to load managed object model") }
        return NSPersistentContainer(name: modelName, managedObjectModel: managedObjectModel)
    }
    
    typealias Database = NSPersistentContainer
    
}
