//
//  CategoryCard.swift
//  treasury
//
//  Created by sugarbaron on 01.08.2021.
//

import SwiftUI
    
struct CategoryCard : View {
    
    private let category: Category
    
    init(_ category: Category) {
        self.category = category
    }
    
    var body: some View {
        VStack {
            Text(category.name).font(.title2)
                .frame(maxWidth: .infinity)
                .padding(5)
                .background(Colors.gray)
                .foregroundColor(Colors.black)
                .cornerRadius(5)
            CategoryMetrics(category)
        }
    }
    
    private var warningColor: Color {
        switch (Double(category.spent.int) / Double(category.plan.int)) {
        case let ratio where ratio < 0.25: return Colors.green
        case let ratio where ratio > 0.75: return Colors.red
        default:                           return Colors.biege
        }
    }
    
}
    

struct CategoryCard_Previews : PreviewProvider {
    static var previews: some View {
        CategoryCard(.init("taxi", 2000, 150))
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
