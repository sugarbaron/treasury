//
//  CentralDatabase.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import CoreData

final class CentralDatabase : CentralStorage {
    
    // MARK: initialization
    
    private let modelName: String = "CentralDatabase"
    private let coreData: CoreDataStorageEngine
    private let periodId: AutoincrementId
    private let categoryId: AutoincrementId
    private let purchaseId: AutoincrementId
    
    init?() {
        guard let coreData: CoreDataStorageEngine = try? CoreDataStorageEngine(modelName: modelName)
        else { Log(error: "[CentralStorage] unable to construct"); return nil }
        self.coreData = coreData
        self.periodId = .init()
        self.categoryId = .init()
        self.purchaseId = .init()
        
        configurePeriodIdProvider()
        configureCategoryIdProvider()
        configurePurchaseIdProvider()
    }
    
    private func configurePeriodIdProvider() {
        context.performAndWait {
            let last: CoreDataPlanningPeriod? = loadLast()
            periodId.setLastId(last?.id?.intValue)
        }
    }
    
    private func configureCategoryIdProvider() {
        context.performAndWait {
            let last: CoreDataCategory? = loadLast()
            categoryId.setLastId(last?.id?.intValue)
        }
    }
    
    private func configurePurchaseIdProvider() {
        context.performAndWait {
            let last: CoreDataPurchase? = loadLast()
            purchaseId.setLastId(last?.id?.intValue)
        }
    }
    
    // MARK: categories
    
    @discardableResult
    func create(from draft: Category.Draft) -> Category {
        let new: Category = .init(categoryId.next, draft)
        context.performAndWait {
            guard let newEmpty: CoreDataCategory = newEmpty() else { return }
            newEmpty.fill(with: new)
            context.saveChanges()
        }
        return new
    }
    
    func update(_ category: Category) {
        context.performAndWait {
            guard let stored: CoreDataCategory = load(for: category.id) else { return }
            stored.fill(with: category)
            context.saveChanges()
        }
    }
    
    func loadCurrentPeriodCategories() -> [Category] {
        var all: [Category] = [ ]
        context.performAndWait {
            guard let currentPeriod: CoreDataPeriod = loadLast(),
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
    
    // MARK: purchases
    
    func loadPurchases(for category: Category) -> [Purchase] {
        var purchases: [Purchase] = [ ]
        context.performAndWait {
            let youngestFirst: NSSortDescriptor = .init(key: PurchaseFields.date, ascending: false)
            let certainCategory: NSPredicate = .init(format: "\(PurchaseFields.category) == \(category.id)")
            let request: FetchRequest<CoreDataPurchase> = .init(context,
                                                                predicate: certainCategory,
                                                                sort: [youngestFirst])
            purchases = request.execute().compactMap { Purchase.construct(from: $0) }
        }
        return purchases
    }
    
    @discardableResult
    func create(from draft: Purchase.Draft) -> Purchase {
        let new: Purchase = .init(purchaseId.next, draft)
        context.performAndWait {
            guard let newEmpty: CoreDataPurchase = newEmpty() else { return }
            newEmpty.fill(with: new)
            context.saveChanges()
        }
        return new
    }
    
    // MARK: planning periods
    
    @discardableResult
    func create(period range: Date.Range) -> PlanningPeriod {
        let new: PlanningPeriod = .init(periodId.next, range)
        context.performAndWait {
            guard let empty: CoreDataPeriod = newEmpty() else { return }
            empty.fill(with: new)
            context.saveChanges()
        }
        return new
    }
    
    func update(_ period: PlanningPeriod) {
        context.performAndWait {
            guard let targetPeriod: CoreDataPeriod = load(for: period.id) else { return }
            targetPeriod.start = period.start
            targetPeriod.end = period.end
            context.saveChanges()
        }
    }
    
    func loadCurrentPeriod() -> PlanningPeriod? {
        var currentPeriod: PlanningPeriod? = nil
        context.performAndWait {
            guard let coreDataPeriod: CoreDataPeriod = loadLast() else { return }
            currentPeriod = PlanningPeriod.construct(from: coreDataPeriod)
        }
        return currentPeriod
    }
    
    func loadAllPeriods() -> [PlanningPeriod] {
        var periods: [PlanningPeriod] = [ ]
        context.performAndWait {
            let descendingIds: NSSortDescriptor = .init(key: PlanningPeriodFields.id, ascending: false)
            let request: FetchRequest<CoreDataPlanningPeriod> = .init(context, sort: [descendingIds])
            let coreDataPeriods: [CoreDataPeriod] = request.execute()
            periods = coreDataPeriods.compactMap { PlanningPeriod.construct(from: $0) }
        }
        return periods
    }
    
    func loadPeriod(for category: Category) -> PlanningPeriod? {
        var categoryPeriod: PlanningPeriod? = nil
        context.performAndWait {
            guard let coreDataPeriod: CoreDataPeriod = load(for: category.planningPeriod) else { return }
            categoryPeriod = PlanningPeriod.construct(from: coreDataPeriod)
        }
        return categoryPeriod
    }
    
    // MARK: subscription
    
    func adjustSubscription<Subscriber:Storage.Subscriber>(_ updates: Storage.SubscriptionConfig)
    -> Storage.Updates<Subscriber> {
        .init(context, updates)
    }
    
}

// MARK: toolkit

extension CentralDatabase {
    
    private func loadLast<E:CoreDataEntity>() -> E? {
        let request: FetchRequest<E> = .init(context, sort: [.init(key: "id", ascending: false)], limit: 1)
        return request.execute().first
    }
    
    private func load<E:CoreDataEntity>(for id: Int) -> E? {
        let certainId: NSPredicate = .init(format: "id == \(id)")
        let request: FetchRequest<E> = .init(context, predicate: certainId)
        return request.execute().first
    }
    
    // short-name way of NSEntityDescription.insertNewObject(...) as? ...
    private func newEmpty<E:CoreDataEntity>() -> E? {
        Description.insertNewObject(forEntityName: E.entityName, into: context) as? E
    }
    
    private var context: NSManagedObjectContext { coreData.context }
    
    private typealias Description = NSEntityDescription
    private typealias CoreDataPeriod = CoreDataPlanningPeriod
    
}
