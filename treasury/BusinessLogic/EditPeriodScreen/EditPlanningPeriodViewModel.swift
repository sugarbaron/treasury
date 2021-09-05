//
//  EditPlanningPeriodViewModel.swift
//  treasury
//
//  Created by sugarbaron on 05.08.2021.
//

import SwiftUI

final class EditPlanningPeriod { }

extension EditPlanningPeriod {
    
    final class ViewModel : ObservableObject {
        
        @Published var periodStart: Date = Date.invalid
        @Published var periodEnd: Date = Date.invalid
        
        private let storage: CentralStorage?
        private let currentPeriod: PlanningPeriod?
        
        init() {
            self.storage = try? Di.inject(CentralStorage?.self)
            self.currentPeriod = storage?.periods.loadCurrentPeriod()
            guard let start: Date = currentPeriod?.start, let end: Date = currentPeriod?.end
            else { Log(error: "[EditPlanningPeriod.ViewModel] unable to load current period"); return }
            self.periodStart = start
            self.periodEnd = end
        }
        
        func editPeriod() {
            guard periodStart != Date.invalid,
                  periodEnd != Date.invalid,
                  periodEnd.timeIntervalSince(periodStart) > 0,
                  let currentPeriod: PlanningPeriod = currentPeriod
            else { return }
            
            let allPeriods: [PlanningPeriod] = storage?.periods.loadAllPeriods() ?? [ ]
            if allPeriods.count > 1 {
                let previousPeriod: PlanningPeriod = allPeriods[allPeriods.count - 2]
                if periodStart.timeIntervalSince(previousPeriod.end) < 0 { periodStart = previousPeriod.end }
            }
            let editedPeriod: PlanningPeriod = .init(currentPeriod.id, (periodStart, periodEnd))
            storage?.periods.update(editedPeriod)
        }
        
    }
    
}
