//
//  CoreDataPurchase+CoreDataProperties.swift
//  treasury
//
//  Created by sugarbaron on 06.08.2021.
//
//

import Foundation
import CoreData


extension CoreDataPurchase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataPurchase> {
        return NSFetchRequest<CoreDataPurchase>(entityName: "Purchase")
    }

    @NSManaged public var category: NSNumber?
    @NSManaged public var comment: String?
    @NSManaged public var date: Date?
    @NSManaged public var price: NSDecimalNumber?
    @NSManaged public var id: NSNumber?

}

extension CoreDataPurchase : Identifiable {

}
