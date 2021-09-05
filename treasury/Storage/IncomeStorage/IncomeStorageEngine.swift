//
//  IncomeStorageEngine.swift
//  treasury
//
//  Created by sugarbaron on 05.09.2021.
//

import CoreData

// MARK: constructor

final class IncomeStorageEngine {
    
    private let context: NSManagedObjectContext
    private let incomeId: AutoincrementId
    
    init(_ context: NSManagedObjectContext) {
        self.context = context
        self.incomeId = IncomeStorageEngine.adjustIdProvider(context)
    }
    
    private static func adjustIdProvider(_ context: NSManagedObjectContext) -> AutoincrementId {
        let idProvider: AutoincrementId = .init()
        context.performAndWait {
            let last: CoreDataIncome? = context.loadLast()
            idProvider.setLastId(last?.id?.intValue)
        }
        return idProvider
    }

}

// MARK: interface

extension IncomeStorageEngine : IncomeStorage {
    
    @discardableResult
    func create(from draft: Income.Draft) -> Income {
        let new: Income = .init(incomeId.next, draft)
        context.performAndWait {
            guard let newEmpty: CoreDataIncome = context.newEmpty() else { return }
            newEmpty.fill(with: new)
            context.saveChanges()
        }
        return new
    }
    
    func update(_ income: Income) {
        context.performAndWait {
            guard let stored: CoreDataIncome = context.load(for: income.id) else { return }
            stored.fill(with: income)
            context.saveChanges()
        }
    }
    
    func loadAll() -> [Income] {
        var incomeList: [Income] = [ ]
        context.performAndWait {
            let byAscendingId: NSSortDescriptor = .init(key: IncomeFields.id, ascending: true)
            let request: FetchRequest<CoreDataIncome> = .init(context, sort: [byAscendingId])
            let read: [CoreDataIncome] = request.execute()
            incomeList = read.compactMap { Income.construct(from: $0) }
        }
        return incomeList
    }
    
    func adjustSubscription<S:StorageSubscriber>(_ updates: Storage.SubscriptionConfig) -> Storage.Updates<S> {
        .init(context, updates)
    }
    
}
