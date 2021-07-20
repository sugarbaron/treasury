//
//  CentralStorage.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

protocol CentralStorage {
    
    func save(_ category: Category)
    
    func load() -> [Category]
    
    func save(_ purchase: Purchase)
    
    func load() -> [Purchase]
    
}
