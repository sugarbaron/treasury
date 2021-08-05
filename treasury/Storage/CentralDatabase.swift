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
    private let periodId: PlanningPeriodId
    
    init?() {
        guard let coreData: CoreDataStorageEngine = try? CoreDataStorageEngine(modelName: modelName)
        else { Log(error: "[CentralStorage] unable to construct"); return nil }
        self.coreData = coreData
        self.periodId = .init()
        
        let lastPeriod: CoreDataPlanningPeriod? = loadLastPeriod()
        self.periodId.setLastId(lastPeriod?.id?.intValue)
    }
    
    // MARK: categories
    
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
    
    func removeCategory(_ categoryName: String) {
        context.performAndWait {
            let certainCategory: NSPredicate = .init(format: "\(CategoryFields.name) == %@", categoryName)
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
    
    // MARK: planning periods
    
    func saveNew(period: Date.Range) {
        context.performAndWait {
            guard let empty: CoreDataPeriod = newEmptyPeriod() else { return }
            empty.id = NSNumber(value: periodId.nextId)
            empty.start = period.from
            empty.end = period.to
            context.saveChanges()
        }
    }
    
    func update(_ period: PlanningPeriod) {
        context.performAndWait {
            let certainId: NSPredicate = .init(format: "\(PlanningPeriodFields.id) == \(period.id)")
            let request: FetchRequest<CoreDataPeriod> = .init(context, predicate: certainId)
            guard let targetPeriod: CoreDataPeriod = request.execute().first else { return }
            targetPeriod.start = period.start
            targetPeriod.end = period.end
        }
    }
    
    func loadCurrentPeriod() -> PlanningPeriod? {
        guard let coreDataPeriod: CoreDataPeriod = loadLastPeriod() else { return nil }
        return PlanningPeriod.construct(from: coreDataPeriod)
    }
    
    private func loadLastPeriod() -> CoreDataPlanningPeriod? {
        var period: CoreDataPlanningPeriod? = nil
        context.performAndWait {
            let descendingIds: NSSortDescriptor = .init(key: PlanningPeriodFields.id, ascending: false)
            let request: FetchRequest<CoreDataPlanningPeriod> = .init(context, sort: [descendingIds], limit: 1)
            period = request.execute().first
        }
        return period
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
            let certainId: NSPredicate = .init(format: "\(PlanningPeriodFields.id) == \(category.planningPeriod)")
            let request: FetchRequest<CoreDataPeriod> = .init(context, predicate: certainId)
            guard let coreDataPeriod: CoreDataPeriod = request.execute().first else { return }
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
    
    // short-name way of NSEntityDescription.insertNewObject(...) as? ...
    private func newEmptyCategory() -> CoreDataCategory? {
        Description.insertNewObject(forEntityName: CoreDataCategory.entityName, into: context) as? CoreDataCategory
    }
    
    private func newEmptyPurchase() -> CoreDataPurchase? {
        Description.insertNewObject(forEntityName: CoreDataPurchase.entityName, into: context) as? CoreDataPurchase
    }
    
    private func newEmptyPeriod() -> CoreDataPeriod? {
        Description.insertNewObject(forEntityName: CoreDataPeriod.entityName, into: context) as? CoreDataPeriod
    }
    
    private var context: NSManagedObjectContext { coreData.context }
    
    private typealias Description = NSEntityDescription
    private typealias CoreDataPeriod = CoreDataPlanningPeriod
    
}
