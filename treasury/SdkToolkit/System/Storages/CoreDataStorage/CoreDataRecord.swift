//
//  CoreDataRecord.swift
//  treasury
//
//  Created by sugarbaron on 09.04.2023.
//

import CoreData

public protocol CoreDataRecord where Self : NSManagedObject {

    associatedtype DataClass
    
    var original: DataClass? { get }
    
    func fill(with original: DataClass)
    
}
