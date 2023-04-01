//
//  CategoriesStorage.swift
//  treasury
//
//  Created by sugarbaron on 05.09.2021.
//

protocol CategoriesStorage {
    
    @discardableResult
    func create(from draft: Category1.Draft) -> Category1
    
    func update(_ category: Category1)
    
    func loadCurrentPeriodCategories() -> [Category1]
    
    func removeCategory(_ id: Int)
    
    func adjustSubscription<Subscriber:Storage.Subscriber>(_ updates: Storage.SubscriptionConfig)
    -> Storage.Updates<Subscriber>
    
}
