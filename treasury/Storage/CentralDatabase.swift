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
            guard let newEmpty: CoreDataCategory = newEmptyCategory() else { return }
            newEmpty.fill(with: category)
            context.saveChanges()
        }
    }
    
    func loadAllCategories() -> [Category] {
        var all: [CoreDataCategory] = []
        context.performAndWait {
            let byPlan: NSSortDescriptor = .init(key: CategoryFields.plan, ascending: true)
            let request: FetchRequest<CoreDataCategory> = .init(context, sort: [byPlan])
            all = request.execute()
        }
        return all.compactMap { Category.construct(from: $0) }
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
