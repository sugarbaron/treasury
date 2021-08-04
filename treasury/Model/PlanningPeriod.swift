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
    
}
