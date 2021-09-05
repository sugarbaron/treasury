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
    
    func adjustSubscription<S:StorageSubscriber>(_ updates: Storage.SubscriptionConfig) -> Storage.Updates<S> {
        .init(context, updates)
    }
    
}
