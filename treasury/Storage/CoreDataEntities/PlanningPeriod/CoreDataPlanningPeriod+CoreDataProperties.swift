//
//  CoreDataPlanningPeriod+CoreDataProperties.swift
//  treasury
//
//  Created by sugarbaron on 04.08.2021.
//
//

import Foundation
import CoreData


extension CoreDataPlanningPeriod {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataPlanningPeriod> {
        return NSFetchRequest<CoreDataPlanningPeriod>(entityName: "PlanningPeriod")
    }

    @NSManaged public var id: NSNumber?
    @NSManaged public var start: Date?
    @NSManaged public var end: Date?

}

extension CoreDataPlanningPeriod : Identifiable {

}
