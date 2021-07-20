//
//  CategoryCell.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import SwiftUI

struct CategoryCell : View {
    
    @ObservedObject var category: Category
    
    init(_ category: Category) { self.category = category }
    
    var body: some View {
        VStack {
            Text(category.name)
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.85, green: 0.8, blue: 0.65))
                .cornerRadius(5)
            
            HStack {
                AmountCard("total:", category.plan.int)
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.85, green: 0.8, blue: 0.65))
                    .cornerRadius(5)
                AmountCard("spent:", category.fact.int)
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.85, green: 0.8, blue: 0.65))
                    .cornerRadius(5)
                AmountCard("left:", category.plan.int - category.fact.int)
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.85, green: 0.8, blue: 0.65))
                    .cornerRadius(5)
            }
            .frame(maxWidth: .infinity)
        }
        
    }
    
}

struct CategoryCell_Previews : PreviewProvider {
    static var previews: some View {
        CategoryCell(.init("taxi", 2000, 150))
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
