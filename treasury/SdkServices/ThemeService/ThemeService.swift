//
//  ThemeService.swift
//  treasury
//
//  Created by sugarbaron on 29.01.2023.
//

public protocol ThemeService {
    
    var current: Theme { get }
    
    var all: [Theme] { get }
    
    func save(new theme: Theme.Draft)
    
    func update(_ theme: Theme)
    
    func delete(_ id: Int)
    
}
