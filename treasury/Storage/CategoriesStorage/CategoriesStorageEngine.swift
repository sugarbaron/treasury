//
//  CategoriesStorageEngine.swift
//  treasury
//
//  Created by sugarbaron on 05.09.2021.
//

import CoreData

// MARK: constructor

final class CategoriesStorageEngine {
    
    private let context: NSManagedObjectContext
    private let categoryId: AutoincrementId
    
    init(_ context: NSManagedObjectContext) {
        self.context = context
        self.categoryId = CategoriesStorageEngine.adjustIdProvider(context)
    }
    
    private static func adjustIdProvider(_ context: NSManagedObjectContext) -> AutoincrementId {
        let categoryIdProvider: AutoincrementId = .init()
        context.performAndWait {
            let last: CoreDataCategory? = context.loadLast()
            categoryIdProvider.setLastId(last?.id?.intValue)
        }
        return categoryIdProvider
    }

}
    
// MARK: interface

extension CategoriesStorageEngine : CategoriesStorage {
    
    @discardableResult
    func create(from draft: Category.Draft) -> Category {
        let new: Category = .init(categoryId.next, draft)
        context.performAndWait {
            guard let newEmpty: CoreDataCategory = context.newEmpty() else { return }
            newEmpty.fill(with: new)
            context.saveChanges()
        }
        return new
    }
    
    func update(_ category: Category) {
        context.performAndWait {
            guard let stored: CoreDataCategory = context.load(for: category.id) else { return }
            stored.fill(with: category)
            context.saveChanges()
        }
    }
    
    func loadCurrentPeriodCategories() -> [Category] {
        var all: [Category] = [ ]
        context.performAndWait {
            guard let currentPeriod: CoreDataPlanningPeriod = context.loadLast(),
                  let currentPeriodId: Int = currentPeriod.id?.intValue
            else { return }
            let forCurrentPeriod: NSPredicate = .init(format: "\(CategoryFields.periodId) == \(currentPeriodId)")
            let expensiveFirst: NSSortDescriptor = .init(key: CategoryFields.plan, ascending: false)
            let abc: NSSortDescriptor = .init(key: CategoryFields.name, ascending: true)
            let request: FetchRequest<CoreDataCategory> = .init(context,
                                                                predicate: forCurrentPeriod,
                                                                sort: [expensiveFirst, abc])
            all = request.execute().compactMap { Category.construct(from: $0) }
        }
        return all
    }
    
    func removeCategory(_ id: Int) {
        context.performAndWait {
            let certainCategory: NSPredicate = .init(format: "\(CategoryFields.id) == \(id)")
            let request: FetchRequest<CoreDataCategory> = .init(context, predicate: certainCategory)
            let requiredCategories: [CoreDataCategory] = request.execute()
            requiredCategories.forEach { context.delete($0) }
            context.saveChanges()
        }
    }
    
    func adjustSubscription<S:StorageSubscriber>(_ updates: Storage.SubscriptionConfig) -> Storage.Updates<S> {
        .init(context, updates)
    }
    
}
