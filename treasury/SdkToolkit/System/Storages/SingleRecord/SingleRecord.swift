//
//  SingleRecord.swift
//  treasury
//
//  Created by sugarbaron on 09.04.2023.
//

public protocol SingleRecord {
    
    associatedtype CoreDataRecordFields : CoreDataRecord where CoreDataRecordFields.DataClass : SingleRecordFields
    
    var engine: StorageEngine<CoreDataRecordFields> { get }
    
    typealias RecordFields = CoreDataRecordFields.DataClass
    
}

public extension SingleRecord {
    
    subscript<T>(dynamicMember field: KeyPath<RecordFields, T>) -> T { engine.load(field) }
    
    subscript<T>(dynamicMember field: WritableKeyPath<RecordFields, T>) -> T {
        get { engine.load(field) }
        set { engine.save(field, newValue) }
    }
    
    
    
}

public protocol SingleRecordFields {
    
    static var empty: Self { get }
    
}
