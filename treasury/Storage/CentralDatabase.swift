//
//  CentralDatabase.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import CoreData

final class CentralDatabase {
    
    private let modelName: String = "TasksDatabase"
    private let coreData: CoreDataStorageEngine
    
    init?() {
        guard let coreData: CoreDataStorageEngine = try? CoreDataStorageEngine(modelName: modelName)
        else { Log(error: "[TasksStorage] unable to construct"); return nil }
        self.coreData = coreData
    }
    
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
