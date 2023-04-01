//
//  PurchaseDatabase.swift
//  treasury
//
//  Created by sugarbaron on 01.04.2023.
//

protocol PurchaseDatabase {
    
    func save(_ purchase: Purchase.Draft)
    
    func update(with purchase: Purchase)
    
    func loadAll() -> [Purchase]
    
    func load(for category: Category) -> [Purchase]
    
}
