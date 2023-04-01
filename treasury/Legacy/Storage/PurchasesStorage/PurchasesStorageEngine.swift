//
//  PurchasesStorageEngine.swift
//  treasury
//
//  Created by sugarbaron on 05.09.2021.
//

import CoreData

// MARK: constructor

final class PurchasesStorageEngine {
    
    private let context: NSManagedObjectContext
    private let purchaseId: AutoincrementId
    
    init(_ context: NSManagedObjectContext) {
        self.context = context
        self.purchaseId = PurchasesStorageEngine.adjustIdProvider(context)
    }
    
    private static func adjustIdProvider(_ context: NSManagedObjectContext) -> AutoincrementId {
        let idProvider: AutoincrementId = .init()
        context.performAndWait {
            let last: CoreDataPurchase? = context.loadLast()
            idProvider.setLastId(last?.id?.intValue)
        }
        return idProvider
    }

}

// MARK: interface

extension PurchasesStorageEngine : PurchasesStorage {
    
    func loadPurchases(for category: Category1) -> [Purchase1] {
        var purchases: [Purchase1] = [ ]
        context.performAndWait {
            let youngestFirst: NSSortDescriptor = .init(key: PurchaseFields.date, ascending: false)
            let certainCategory: NSPredicate = .init(format: "\(PurchaseFields.category) == \(category.id)")
            let request: FetchRequest<CoreDataPurchase> = .init(context,
                                                                predicate: certainCategory,
                                                                sort: [youngestFirst])
            purchases = request.execute().compactMap { Purchase1.construct(from: $0) }
        }
        return purchases
    }
    
    @discardableResult
    func create(from draft: Purchase1.Draft) -> Purchase1 {
        let new: Purchase1 = .init(purchaseId.next, draft)
        context.performAndWait {
            guard let newEmpty: CoreDataPurchase = context.newEmpty() else { return }
            newEmpty.fill(with: new)
            context.saveChanges()
        }
        return new
    }
    
    func adjustSubscription<S:StorageSubscriber>(_ updates: Storage.SubscriptionConfig) -> Storage.Updates<S> {
        .init(context, updates)
    }
    
}
