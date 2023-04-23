//
//  CoreDataStorage.swift
//  treasury
//
//  Created by sugarbaron on 09.04.2023.
//

import CoreData

/// namespace class
public final class CoreDataStorage { }

// MARK: constructor
public extension CoreDataStorage {
    
    final class Engine {
        
        private let storage: NSPersistentContainer
        private let context: NSManagedObjectContext
        
        /// specify xcdatamodel filename without extension
        /// example: `.init(xcdatamodel: "MyStorage")`
        public init?(xcdatamodel fileName: String, bundle: Bundle? = nil) {
            guard let storage: NSPersistentContainer = .load(model: fileName, from: bundle) else { return nil }
            self.storage = storage
            self.context = storage.newBackgroundContext()
        }
        
    }
    
}

private extension NSPersistentContainer {
    
    static func load(model: String, from bundle: Bundle?) -> NSPersistentContainer? {
        guard let engine: NSPersistentContainer = construct(model, from: bundle)
        else { return Log.nil("[CoreDataStorage] not constructed:[\(model)] bundle:[\((bundle?.id).log)]") }
        
        engine.loadPersistentStores { if $1 != nil { Log(error: "[CoreDataStorage] start failed:[\($0)][\($1.log)]") } }
        return engine
    }
    
    private static func construct(_ modelName: String, from bundle: Bundle?) -> NSPersistentContainer? {
        guard let bundle else { return NSPersistentContainer(name: modelName) }
        guard let modelURL: URL = bundle.url(forResource: modelName, withExtension: "momd"),
              let model: NSManagedObjectModel = .init(contentsOf: modelURL)
        else { return Log.nil("[CoreDataStorage] unable to load model:[\(modelName)] from bundle") }
        return NSPersistentContainer(name: modelName, managedObjectModel: model)
    }
    
}

// MARK: interface
public extension CoreDataStorage.Engine {
    
    func write(_ transaction: (CoreDataAccess) -> Void, catch: () -> Void = { }) {
        context.performAndWait { transaction(context.access); do { try save() } catch { `catch`() } }
    }
    
    func read<R:CoreDataRecord>(_ transaction: (CoreDataRead) -> R?) -> R.DataClass? {
        var original: R.DataClass? = nil
        context.performAndWait { let record: R? = transaction(context.access); original = record?.original }
        return original
    }
    
    func read<R:CoreDataRecord>(_ transaction: (CoreDataRead) -> [R]) -> [R.DataClass] {
        var original: [R.DataClass] = [ ]
        context.performAndWait {
            let records: [R] = transaction(context.access)
            original = records.compactMap { $0.original }
        }
        return original
    }
    
    func keepInformed<R:CoreDataRecord>(_ config: CoreDataStorage.DataStream<R>.Config)
    -> CoreDataStorage.DataStream<R> {
        .init(config, context)
    }
    
}


// MARK: tools
private extension CoreDataStorage.Engine {
    
    private func save() throws { if context.hasChanges { try context.save() } }
    
}

private extension Bundle { var id: String? { bundleIdentifier } }
