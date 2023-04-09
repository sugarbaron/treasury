//
//  CoreDataStorage.swift
//  treasury
//
//  Created by sugarbaron on 09.04.2023.
//

import CoreData

/// namespace class
public final class CoreDataStorage { }


public extension CoreDataStorage {
    
    final class Engine {
        
        private let storage: NSPersistentContainer
        
        public let context: NSManagedObjectContext
        
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
        else { return Log.nil("[CoreDataStorage] not constructed:[\(model)] bundle:[\(bundle?.bundleIdentifier.log)]") }
        
        engine.loadPersistentStores { if $1 != nil { Log(error: "[CoreDataStorage] unable to start:[\($0)][\($1)]") } }
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
