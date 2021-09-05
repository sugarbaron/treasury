//
//  PlanningPeriodCoreDataConvertions.swift
//  treasury
//
//  Created by sugarbaron on 04.08.2021.
//

import Foundation

extension PlanningPeriod : CoreDataConvertible {
    
    static func construct(from coreDataEntity: CoreDataPlanningPeriod) -> PlanningPeriod? {
        guard let id: Int = coreDataEntity.id?.intValue,
              let start: Date = coreDataEntity.start,
              let end: Date = coreDataEntity.end
        else { Log(error: "[PlanningPeriod] unable to construct from coreDataEntity"); return nil }
        
        return .init(id, (start, end))
    }
    
}

extension CoreDataPlanningPeriod {
    
    func fill(with period: PlanningPeriod) {
        self.id = NSNumber(value: period.id)
        self.start = period.start
        self.end = period.end
    }
    
}
