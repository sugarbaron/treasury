//
//  SingleRecordStorageEngine.swift
//  treasury
//
//  Created by sugarbaron on 23.04.2023.
//

import Foundation
import Combine

public extension SingleRecord { typealias StorageEngine = SingleRecordStorageEngine }

// MARK: constructor
public class SingleRecordStorageEngine<CoreDataRecordFields:CoreDataRecord>
where CoreDataRecordFields.DataClass : SingleRecordFields {
    
    private let storage: CoreDataStorage.Engine
    private var cache: RecordFields
    private let cacheAccess: NSRecursiveLock
    private let downstream: CurrentValueSubject<RecordFields, Never>
    
    public init?(xcdatamodel fileName: String) {
        guard let storage: CoreDataStorage.Engine = .init(xcdatamodel: fileName)
        else { Log(error: "[SingleRecord][\(type(of: RecordFields.self))] unable to construct"); return nil }
        
        self.storage = storage
        self.cache = storage.load(CoreDataRecordFields.self)
        self.cacheAccess = NSRecursiveLock()
        self.downstream = CurrentValueSubject<RecordFields, Never>(cache)
        downstream.send(cache)
    }
    
}

// MARK: interface
public extension SingleRecord.StorageEngine {
    
    func load<T>(_ field: KeyPath<RecordFields, T>) -> T { readCache(field) }
    
    func save<T>(_ field: WritableKeyPath<RecordFields, T>, _ new: T) { update(field, with: new) }
    
    func keepInformed<T:Equatable>(about field: KeyPath<RecordFields, T>) -> AnyPublisher<T, Never> {
        downstream
            .compactMap { $0[keyPath: field] }
            .removeDuplicates { new, old in new == old }
            .anyPublisher
    }
    
    func keepInformed<T>(about field: KeyPath<RecordFields, T>, skip: @escaping (T, T) -> Bool)
    -> AnyPublisher<T, Never> {
        downstream.compactMap { $0[keyPath: field] }
            .removeDuplicates { skip($0, $1) }
            .anyPublisher
    }
    
    func erase() {
        cacheAccess.lock()
        cache = .empty
        cacheAccess.unlock()
        storage.write { $0.delete(all: CoreDataRecordFields.self) }
    }
    
    typealias RecordFields = CoreDataRecordFields.DataClass
    
}

// MARK: tools
private extension SingleRecord.StorageEngine {
    
    func load() -> RecordFields { storage.read { $0.loadAll(CoreDataRecordFields.self).first } ?? .empty }
    
    func readCache<T>(_ fieldKey: KeyPath<RecordFields, T>) -> T {
        cacheAccess.lock()
        let field: T = cache[keyPath: fieldKey]
        cacheAccess.unlock()
        return field
    }
    
    func update<T>(_ field: WritableKeyPath<RecordFields, T>, with new: T) {
        let updated: RecordFields = updateCache(field, with: new)
        downstream.send(updated)
        storage.update(single: updated, as: CoreDataRecordFields.self)
    }
    
    func updateCache<T>(_ field: WritableKeyPath<RecordFields, T>, with new: T) -> RecordFields {
        cacheAccess.lock()
        cache[keyPath: field] = new
        let updated: RecordFields = cache
        cacheAccess.unlock()
        return updated
    }
    
}

private extension CoreDataStorage.Engine {
    
    func load<R:CoreDataRecord>(_ recordType: R.Type) -> R.DataClass where R.DataClass : SingleRecordFields {
        read { $0.loadAll(R.self).first } ?? .empty
    }
    
    func update<R:CoreDataRecord>(single original: R.DataClass, as record: R.Type) {
        write { storage in
            if let record: R = storage.loadAll().first {
                record.fill(with: original)
            } else {
                storage.create(new: original, as: R.self)
            }
        } catch: { Log(error: "[SingleRecordStorage] updateSingle() error") }
    }
    
}
