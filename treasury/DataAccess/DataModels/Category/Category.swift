//
//  Category.swift
//  treasury
//
//  Created by sugarbaron on 01.04.2023.
//

final class Category {
    
    let id: Int
    let name: String
    let iconName: String
    
    init(id: Int, name: String, iconName: String) {
        self.id = id
        self.name = name
        self.iconName = iconName
    }
    
}

extension Category {
    
    final class Draft {
        
        let name: String
        let iconName: String
        
        init(name: String, iconName: String) {
            self.name = name
            self.iconName = iconName
        }
        
    }
    
}
