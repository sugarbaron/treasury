//
//  IncomeStorage.swift
//  treasury
//
//  Created by sugarbaron on 05.09.2021.
//

protocol IncomeStorage {
    
    func create(from draft: Income.Draft) -> Income
    
    func update(_ income: Income)
    
    func loadAll() -> [Income]
    
    func adjustSubscription<Subscriber:Storage.Subscriber>(_ updates: Storage.SubscriptionConfig)
    -> Storage.Updates<Subscriber>
    
}
