//
//  PlanningPeriodsStorage.swift
//  treasury
//
//  Created by sugarbaron on 05.09.2021.
//

import Foundation

protocol PlanningPeriodsStorage {
    
    @discardableResult
    func create(period range: Date.Range) -> PlanningPeriod
    
    func update(_ period: PlanningPeriod)
    
    func loadCurrentPeriod() -> PlanningPeriod?
    
    func loadAllPeriods() -> [PlanningPeriod]
    
    func loadPeriod(for category: Category) -> PlanningPeriod?
    
    func adjustSubscription<Subscriber:Storage.Subscriber>(_ updates: Storage.SubscriptionConfig)
    -> Storage.Updates<Subscriber>
    
}
