//
//  CoreDataCategory+CoreDataProperties.swift
//  treasury
//
//  Created by sugarbaron on 06.08.2021.
//
//

import Foundation
import CoreData


extension CoreDataCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataCategory> {
        return NSFetchRequest<CoreDataCategory>(entityName: "Category")
    }

    @NSManaged public var fact: NSDecimalNumber?
    @NSManaged public var name: String?
    @NSManaged public var periodId: NSNumber?
    @NSManaged public var plan: NSDecimalNumber?
    @NSManaged public var id: NSNumber?

}

extension CoreDataCategory : Identifiable {

}
