//
//  PurchasesStorage.swift
//  treasury
//
//  Created by sugarbaron on 05.09.2021.
//

protocol PurchasesStorage {
    
    @discardableResult
    func create(from draft: Purchase1.Draft) -> Purchase1
    
    func loadPurchases(for category: Category1) -> [Purchase1]
    
    func adjustSubscription<Subscriber:Storage.Subscriber>(_ updates: Storage.SubscriptionConfig)
    -> Storage.Updates<Subscriber>
    
}
