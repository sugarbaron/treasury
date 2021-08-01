//
//  CentralStorage.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

protocol CentralStorage {
    
    func save(_ category: Category)
    
    func loadAllCategories() -> [Category]
    
    func adjustSubscription<Subscriber:Storage.Subscriber>(_ updates: Storage.SubscriptionConfig)
    -> Storage.Updates<Subscriber>
    
    func save(_ purchase: Purchase)
    
    // todo: func loadAllPurchases() -> [Purchase]
    
}
