//
//  CategoryDatabase.swift
//  treasury
//
//  Created by sugarbaron on 01.04.2023.
//

protocol CategoryDatabase {
    
    func save(_ category: Category.Draft)
    
    func update(with category: Category)
    
    func loadAll() -> [Category]
    
}
