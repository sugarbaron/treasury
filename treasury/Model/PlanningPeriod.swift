//
//  PlanningPeriod.swift
//  treasury
//
//  Created by sugarbaron on 04.08.2021.
//

import Foundation

final class PlanningPeriod {
    
    let id: Int
    let start: Date
    let end: Date
    
    init(_ id: Int, _ range: Date.Range) {
        self.id = id
        self.start = range.from
        self.end = range.to
    }
    
    func isDifferent(than another: PlanningPeriod?) -> Bool {
        guard let another: PlanningPeriod  = another else { return true }
        return (self.id != another.id)
            || (self.start != another.start)
            || (self.end != another.end)
    }
    
}
