//
//  PurchasesStorage.swift
//  treasury
//
//  Created by sugarbaron on 05.09.2021.
//

protocol PurchasesStorage {
    
    @discardableResult
    func create(from draft: Purchase.Draft) -> Purchase
    
    func loadPurchases(for category: Category) -> [Purchase]
    
    func adjustSubscription<Subscriber:Storage.Subscriber>(_ updates: Storage.SubscriptionConfig)
    -> Storage.Updates<Subscriber>
    
}
