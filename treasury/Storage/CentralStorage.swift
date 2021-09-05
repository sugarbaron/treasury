//
//  CentralStorage.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import Foundation

protocol CentralStorage {
    
    // MARK: category
    
    @discardableResult
    func create(from draft: Category.Draft) -> Category
    
    func update(_ category: Category)
    
    func loadCurrentPeriodCategories() -> [Category]
    
    func removeCategory(_ id: Int)
    
    // MARK: purchase
    
    @discardableResult
    func create(from draft: Purchase.Draft) -> Purchase
    
    func loadPurchases(for category: Category) -> [Purchase]
    
    // MARK: planning period
    
    @discardableResult
    func create(period range: Date.Range) -> PlanningPeriod
    
    func update(_ period: PlanningPeriod)
    
    func loadCurrentPeriod() -> PlanningPeriod?
    
    func loadAllPeriods() -> [PlanningPeriod]
    
    func loadPeriod(for category: Category) -> PlanningPeriod?
    
    // MARK: subscription
    
    func adjustSubscription<Subscriber:Storage.Subscriber>(_ updates: Storage.SubscriptionConfig)
    -> Storage.Updates<Subscriber>
    
}
