//
//  CoreDataAccess.swift
//  treasury
//
//  Created by sugarbaron on 09.04.2023.
//

public typealias CoreDataAccess = CoreDataRead & CoreDataWrite

// MARK: read tools
public protocol CoreDataRead {
    
    func loadAll<R:CoreDataRecord>() -> [R]
    
    func load<R:CoreDataRecord>(_ id: Int) -> R?
    
    func load<R:CoreDataRecord>(_ id: String) -> R?
    
    func load<R:CoreDataRecord>(_ ids: [Int]) -> [R]
    
    func load<R:CoreDataRecord>(_ ids: [String]) -> [R]
    
    func load<R:CoreDataRecord>(where predicate: Predicate, _ sort: [Sort], _ limit: Int?) -> [R]
    
}

public extension CoreDataRead {
    
    func load<R:CoreDataRecord>(where predicate: Predicate, sort: [Sort] = [ ], limit: Int? = nil) -> [R] {
        load(where: predicate, sort, limit)
    }
    
    func load<R:CoreDataRecord>(where predicate: Predicate, sort: [Sort] = [ ], limit: Int? = nil) -> R? {
        load(where: predicate, sort, limit).first
    }
    
}

// MARK: write tools
public protocol CoreDataWrite {
    
    func save<R:CoreDataRecord>(_ original: R.DataClass, as record: R.Type, with id: Int)
    
    func save<R:CoreDataRecord>(_ original: R.DataClass, as record: R.Type, with id: String)
    
    func update<R:CoreDataRecord>(with original: R.DataClass, _ record: R.Type, where id: Int)
    
    func update<R:CoreDataRecord>(with original: R.DataClass, _ record: R.Type, where id: String)
    
    func create<R:CoreDataRecord>(new original: R.DataClass, as new: R.Type)
    
    func create<R:CoreDataRecord>(new originals: [R.DataClass], as new: R.Type)
    
    func delete<R:CoreDataRecord>(_ record: R.Type, with id: Int)
    
    func delete<R:CoreDataRecord>(_ record: R.Type, with id: String)
    
    func delete<R:CoreDataRecord>(_ records: R.Type, with ids: [Int])
    
    func delete<R:CoreDataRecord>(_ records: R.Type, with ids: [String])
    
    func delete<R:CoreDataRecord>(all records: R.Type)
    
}
