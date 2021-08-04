//
//  CentralStorage.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import Foundation

protocol CentralStorage {
    
    func save(_ category: Category)
    
    func loadAllCategories() -> [Category]
    
    func removeCategory(_ categoryName: String)
    
    func adjustSubscription<Subscriber:Storage.Subscriber>(_ updates: Storage.SubscriptionConfig)
    -> Storage.Updates<Subscriber>
    
    func save(_ purchase: Purchase)
    
    func loadPurchases(for category: Category) -> [Purchase]
    
    // todo: func loadAllPurchases() -> [Purchase]
    
    func save(planningPeriod: Date.Range)
    
    func loadLastPlanningPeriod() -> PlanningPeriod?
    
    func loadAllPlanningPeriods() -> [PlanningPeriod]
    
}
