//
//  BasicDatabaseOperations.swift
//  treasury
//
//  Created by sugarbaron on 05.09.2021.
//

import CoreData

extension NSManagedObjectContext {
    
    func loadLast<E:CoreDataEntity>() -> E? {
        let request: FetchRequest<E> = .init(self, sort: [.init(key: "id", ascending: false)], limit: 1)
        return request.execute().first
    }
    
    func load<E:CoreDataEntity>(for id: Int) -> E? {
        let certainId: NSPredicate = .init(format: "id == \(id)")
        let request: FetchRequest<E> = .init(self, predicate: certainId, limit: 1)
        return request.execute().first
    }
    
    // short-name way of NSEntityDescription.insertNewObject(...) as? ...
    func newEmpty<E:CoreDataEntity>() -> E? {
        Description.insertNewObject(forEntityName: E.entityName, into: self) as? E
    }
    
    private typealias Description = NSEntityDescription
    
}
