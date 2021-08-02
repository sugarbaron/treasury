//
//  CentralDatabase.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import CoreData

final class CentralDatabase : CentralStorage {
    
    private let modelName: String = "CentralDatabase"
    private let coreData: CoreDataStorageEngine
    
    init?() {
        guard let coreData: CoreDataStorageEngine = try? CoreDataStorageEngine(modelName: modelName)
        else { Log(error: "[CentralStorage] unable to construct"); return nil }
        self.coreData = coreData
    }
    
    func save(_ category: Category) {
        context.performAndWait {
            guard let newEmpty: CoreDataCategory = loadCategory(category.name) ?? newEmptyCategory()
            else { return }
            newEmpty.fill(with: category)
            context.saveChanges()
        }
    }
    
    private func loadCategory(_ name: String) -> CoreDataCategory? {
        let certainName: NSPredicate = .init(format: "\(CategoryFields.name) == %@", name)
        let request = FetchRequest<CoreDataCategory>(context, predicate: certainName)
        return request.execute().first
    }
    
    func loadAllCategories() -> [Category] {
        var all: [Category] = [ ]
        context.performAndWait {
            let expensiveFirst: NSSortDescriptor = .init(key: CategoryFields.plan, ascending: false)
            let abc: NSSortDescriptor = .init(key: CategoryFields.name, ascending: true)
            let request: FetchRequest<CoreDataCategory> = .init(context, sort: [expensiveFirst, abc])
            all = request.execute().compactMap { Category.construct(from: $0) }
        }
        return all
    }
    
    func loadPurchases(for category: Category) -> [Purchase] {
        var purchases: [Purchase] = [ ]
        context.performAndWait {
            let youngestFirst: NSSortDescriptor = .init(key: PurchaseFields.date, ascending: false)
            let certainCategory: NSPredicate = .init(format: "\(PurchaseFields.category) == %@", category.name)
            let request: FetchRequest<CoreDataPurchase> = .init(context,
                                                                predicate: certainCategory,
                                                                sort: [youngestFirst])
            purchases = request.execute().compactMap { Purchase.construct(from: $0) }
        }
        return purchases
    }
    
    func save(_ purchase: Purchase) {
        context.performAndWait {
            guard let newEmpty: CoreDataPurchase = newEmptyPurchase() else { return }
            newEmpty.fill(with: purchase)
            context.saveChanges()
        }
    }
    
    func adjustSubscription<Subscriber:Storage.Subscriber>(_ updates: Storage.SubscriptionConfig)
    -> Storage.Updates<Subscriber> {
        .init(context, updates)
    }
    
}

extension CentralDatabase {
    
    // short-name way of NSEntityDescription.insertNewObject(...) as? ...
    private func newEmptyCategory() -> CoreDataCategory? {
        Description.insertNewObject(forEntityName: CoreDataCategory.entityName, into: context) as? CoreDataCategory
    }
    
    private func newEmptyPurchase() -> CoreDataPurchase? {
        Description.insertNewObject(forEntityName: CoreDataPurchase.entityName, into: context) as? CoreDataPurchase
    }
    
    private var context: NSManagedObjectContext { coreData.context }
    
    private typealias Description = NSEntityDescription
    
}
