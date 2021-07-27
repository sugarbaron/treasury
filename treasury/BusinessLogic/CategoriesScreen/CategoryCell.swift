//
//  CategoryCell.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import SwiftUI

extension Categories {
    
    struct Cell : View {
        
        private let category: Category
        private var width: Binding<CGFloat>
        
        init(_ category: Category, _ width: Binding<CGFloat>) {
            self.category = category
            self.width = width
        }
        
        var body: some View {
            VStack {
                Text(category.name).font(.title2)
                    .frame(maxWidth: .infinity)
                    .padding(5)
                    .background(Colors.blue)
                    .foregroundColor(Colors.white)
                    .cornerRadius(5)
                
                HStack {
                    AmountCard("total:", category.plan.int)
                        .frame(maxWidth: .infinity)
                        .background(Colors.biege)
                        .cornerRadius(5)
                    AmountCard("spent:", category.spent.int)
                        .frame(maxWidth: .infinity)
                        .background(Colors.biege)
                        .cornerRadius(5)
                    AmountCard("left:", category.plan.int - category.spent.int)
                        .frame(maxWidth: .infinity)
                        .background(warningColor)
                        .cornerRadius(5)
                }
                .frame(maxWidth: .infinity)
            }
            .background(GeometryReader { geometry in Colors.background.onAppear {
                width.wrappedValue = geometry.size.width
            } }.frame(maxWidth: .infinity))
        }
        
        private var warningColor: Color {
            switch (Double(category.spent.int) / Double(category.plan.int)) {
            case let ratio where ratio < 0.25: return Colors.green
            case let ratio where ratio > 0.75: return Colors.red
            default:                           return Colors.biege
            }
        }
        
    }
    
}

struct CategoryCell_Previews : PreviewProvider {
    static var previews: some View {
        Categories.Cell(.init("taxi", 2000, 150), .constant(350))
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
