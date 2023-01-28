//
//  CoreDataEntity.swift
//  treasury
//
//  Created by sugarbaron on 25.07.2021.
//

import CoreData

public protocol CoreDataConvertible {
    
    associatedtype CoreDataClass : CoreDataEntity
    
    static func construct(from coreDataEntity: CoreDataClass) -> Self?
    
}


public protocol CoreDataEntity where Self : NSManagedObject {
    
    static var entityName: String { get }
    
}
