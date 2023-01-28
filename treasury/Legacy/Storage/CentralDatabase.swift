//
//  CentralDatabase.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

// MARK: constructor

import CoreData

final class CentralDatabase : CentralStorage {
    
    let categories: CategoriesStorage
    let purchases: PurchasesStorage
    let periods: PlanningPeriodsStorage
    let income: IncomeStorage
    
    private let modelName: String = "CentralDatabase"
    private let coreData: CoreDataStorageEngine
    
    init?() {
        guard let coreData: CoreDataStorageEngine = try? CoreDataStorageEngine(modelName: modelName)
        else { Log(error: "[CentralStorage] unable to construct"); return nil }
        
        self.coreData = coreData
        self.categories = CategoriesStorageEngine(coreData.context)
        self.purchases = PurchasesStorageEngine(coreData.context)
        self.periods = PlanningPeriodsStorageEngine(coreData.context)
        self.income = IncomeStorageEngine(coreData.context)
    }
    
}
