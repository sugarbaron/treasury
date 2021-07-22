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
            Text(category.name).font(.title2)
                .frame(maxWidth: .infinity)
                .padding(5)
                .background(Colors.blue)
                .foregroundColor(.white)
                .cornerRadius(5)
            
            HStack {
                AmountCard("total:", category.plan.int)
                    .frame(maxWidth: .infinity)
                    .background(Colors.yellow)
                    .cornerRadius(5)
                AmountCard("spent:", category.fact.int, Colors.red)
                    .frame(maxWidth: .infinity)
                    .background(Colors.yellow)
                    .cornerRadius(5)
                AmountCard("left:", category.plan.int - category.fact.int, warningColor)
                    .frame(maxWidth: .infinity)
                    .background(Colors.yellow)
                    .cornerRadius(5)
            }
            .frame(maxWidth: .infinity)
        }
        
    }
    
    private var warningColor: Color {
        (category.plan.int - category.fact.int) < 0
            ? Colors.red
            : Colors.green
        
    }
    
}

struct CategoryCell_Previews : PreviewProvider {
    static var previews: some View {
        CategoryCell(.init("taxi", 2000, 150))
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
