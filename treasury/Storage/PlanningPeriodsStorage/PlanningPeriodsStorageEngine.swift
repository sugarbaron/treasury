//
//  PlanningPeriodsStorageEngine.swift
//  treasury
//
//  Created by sugarbaron on 05.09.2021.
//

import CoreData

// MARK: constructor

final class PlanningPeriodsStorageEngine {
    
    private let context: NSManagedObjectContext
    private let periodId: AutoincrementId
    
    init(_ context: NSManagedObjectContext) {
        self.context = context
        self.periodId = PlanningPeriodsStorageEngine.adjustIdProvider(context)
    }
    
    private static func adjustIdProvider(_ context: NSManagedObjectContext) -> AutoincrementId {
        let idProvider: AutoincrementId = .init()
        context.performAndWait {
            let last: CoreDataPlanningPeriod? = context.loadLast()
            idProvider.setLastId(last?.id?.intValue)
        }
        return idProvider
    }

}

// MARK: interface

extension PlanningPeriodsStorageEngine : PlanningPeriodsStorage {
    
    @discardableResult
    func create(period range: Date.Range) -> PlanningPeriod {
        let new: PlanningPeriod = .init(periodId.next, range)
        context.performAndWait {
            guard let empty: CoreDataPeriod = context.newEmpty() else { return }
            empty.fill(with: new)
            context.saveChanges()
        }
        return new
    }
    
    func update(_ period: PlanningPeriod) {
        context.performAndWait {
            guard let targetPeriod: CoreDataPeriod = context.load(for: period.id) else { return }
            targetPeriod.start = period.start
            targetPeriod.end = period.end
            context.saveChanges()
        }
    }
    
    func loadCurrentPeriod() -> PlanningPeriod? {
        var currentPeriod: PlanningPeriod? = nil
        context.performAndWait {
            guard let coreDataPeriod: CoreDataPeriod = context.loadLast() else { return }
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
            guard let coreDataPeriod: CoreDataPeriod = context.load(for: category.planningPeriod) else { return }
            categoryPeriod = PlanningPeriod.construct(from: coreDataPeriod)
        }
        return categoryPeriod
    }
    
    func adjustSubscription<S:StorageSubscriber>(_ updates: Storage.SubscriptionConfig) -> Storage.Updates<S> {
        .init(context, updates)
    }
    
    private typealias CoreDataPeriod = CoreDataPlanningPeriod
    
}
