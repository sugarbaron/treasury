//
//  PlanningPeriodFields.swift
//  treasury
//
//  Created by sugarbaron on 04.08.2021.
//

extension CoreDataPlanningPeriod : CoreDataEntity { public static var entityName = "PlanningPeriod" }

final class PlanningPeriodFields {
    
    static let id: String = "id"
    static let start: String = "start"
    static let end: String = "end"
    
}
