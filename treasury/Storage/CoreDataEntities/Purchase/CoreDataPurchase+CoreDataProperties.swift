//
//  CoreDataPurchase+CoreDataProperties.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//
//

import Foundation
import CoreData


extension CoreDataPurchase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataPurchase> {
        return NSFetchRequest<CoreDataPurchase>(entityName: "Purchase")
    }

    @NSManaged public var price: NSDecimalNumber?
    @NSManaged public var date: Date?
    @NSManaged public var comment: String?
    @NSManaged public var category: String?

}

extension CoreDataPurchase : Identifiable {

}
