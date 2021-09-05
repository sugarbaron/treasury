//
//  CoreDataIncome+CoreDataProperties.swift
//  treasury
//
//  Created by sugarbaron on 05.09.2021.
//
//

import Foundation
import CoreData


extension CoreDataIncome {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataIncome> {
        return NSFetchRequest<CoreDataIncome>(entityName: "Income")
    }

    @NSManaged public var id: NSNumber?
    @NSManaged public var amount: NSDecimalNumber?
    @NSManaged public var date: Date?
    @NSManaged public var comment: String?

}

extension CoreDataIncome : Identifiable {

}
