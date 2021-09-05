//
//  IncomeStorage.swift
//  treasury
//
//  Created by sugarbaron on 05.09.2021.
//

protocol IncomeStorage {
    
    func adjustSubscription<Subscriber:Storage.Subscriber>(_ updates: Storage.SubscriptionConfig)
    -> Storage.Updates<Subscriber>
    
}
