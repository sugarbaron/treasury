//
//  CategoriesStorage.swift
//  treasury
//
//  Created by sugarbaron on 05.09.2021.
//

protocol CategoriesStorage {
    
    @discardableResult
    func create(from draft: Category.Draft) -> Category
    
    func update(_ category: Category)
    
    func loadCurrentPeriodCategories() -> [Category]
    
    func removeCategory(_ id: Int)
    
    func adjustSubscription<Subscriber:Storage.Subscriber>(_ updates: Storage.SubscriptionConfig)
    -> Storage.Updates<Subscriber>
    
}
