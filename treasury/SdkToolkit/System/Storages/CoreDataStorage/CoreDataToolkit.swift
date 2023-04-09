//
//  CoreDataToolkit.swift
//  treasury
//
//  Created by sugarbaron on 09.04.2023.
//

import CoreData

// MARK: constructor
internal final class CoreDataToolkit : CoreDataReadTools, CoreDataWriteTools {
    
    private var context: CoreDataStorage.Context
    
    internal init(_ context: CoreDataStorage.Context) { self.context = context }
    
}

internal extension CoreDataStorage { typealias Context = NSManagedObjectContext }

// MARK: interface: save
internal extension CoreDataToolkit {
    
    func save<R:CoreDataRecord>(_ original: R.DataClass, as record: R.Type, with id: Int) {
        guard let record: R = load(id) ?? create() else { return }
        record.fill(with: original)
    }
    
    func save<R:CoreDataRecord>(_ original: R.DataClass, as record: R.Type, with id: String) {
        guard let record: R = load(id) ?? create() else { return }
        record.fill(with: original)
    }
    
    func update<R:CoreDataRecord>(with original: R.DataClass, _ record: R.Type, where id: Int) {
        guard let record: R = load(id) else { return }
        record.fill(with: original)
    }
    
    func update<R:CoreDataRecord>(with original: R.DataClass, _ record: R.Type, where id: String) {
        guard let record: R = load(id) else { return }
        record.fill(with: original)
    }
    
    func create<R:CoreDataRecord>(new original: R.DataClass, as new: R.Type) {
        guard let record: R = create() else { return }
        record.fill(with: original)
    }
    
    func create<R:CoreDataRecord>(new originals: [R.DataClass], as new: R.Type) {
        originals.forEach { if let record: R = create() { record.fill(with: $0) } }
    }
    
}

// MARK: interface: load
internal extension CoreDataToolkit {
    
    func loadAll<R:CoreDataRecord>() -> [R] { Request<R>(context, where: .all)?.execute() ?? [ ] }
    
    func load<R:CoreDataRecord>(_ id: Int) -> R? {
        let certainId: Predicate = .init(format: "id == \(id)")
        let request: Request<R>? = .init(context, where: certainId)
        return request?.execute().first
    }
    
    func load<R:CoreDataRecord>(_ id: String) -> R? {
        let certainId: Predicate = .init(format: "id == %@", id)
        let request: Request<R>? = .init(context, where: certainId)
        return request?.execute().first
    }
    
    func load<R:CoreDataRecord>(_ ids: [Int]) -> [R] {
        let certainId: Predicate = .init(format: "id IN %@", ids)
        let request: Request<R>? = .init(context, where: certainId)
        return request?.execute() ?? [ ]
    }
    
    func load<R:CoreDataRecord>(_ ids: [String]) -> [R] {
        let certainId: Predicate = .init(format: "id IN %@", ids)
        let request: Request<R>? = .init(context, where: certainId)
        return request?.execute() ?? [ ]
    }
    
    
    func load<R:CoreDataRecord>(where predicate: Predicate, _ sort: [Sort], _ limit: Int?) -> [R] {
        Request<R>(context, where: predicate, sort: sort, limit: limit)?.execute() ?? [ ]
    }
    
}

// MARK: interface: delete
internal extension CoreDataToolkit {
    
    func delete<R:CoreDataRecord>(_ record: R.Type, with id: Int) {
        if let record: R = load(id) { context.delete(record) }
    }
    
    func delete<R:CoreDataRecord>(_ record: R.Type, with id: String) {
        if let record: R = load(id) { context.delete(record) }
    }
    
    func delete<R:CoreDataRecord>(_ records: R.Type, with ids: [Int]) {
        let records: [R] = load(ids)
        records.forEach { context.delete($0) }
    }
    
    func delete<R:CoreDataRecord>(_ records: R.Type, with ids: [String]) {
        let records: [R] = load(ids)
        records.forEach { context.delete($0) }
    }
    
    func delete<R:CoreDataRecord>(all records: R.Type) {
        let all: [R] = loadAll()
        all.forEach { context.delete($0) }
    }
    
}

internal extension CoreDataStorage.Context { var toolkit: CoreDataToolkit { .init(self) } }

// MARK: tools
private extension CoreDataToolkit {
    
    func create<R:CoreDataRecord>() -> R? {
        guard let name: String = R.entity().name,
              let record: R = NSEntityDescription.insertNewObject(forEntityName: name, into: context) as? R
        else { Log(error: "[CoreDataStorage] unable to create:[\(name(of: R.self))]"); return nil }
        return record
    }
    
    typealias Request = CoreDataStorage.Request
    
}
