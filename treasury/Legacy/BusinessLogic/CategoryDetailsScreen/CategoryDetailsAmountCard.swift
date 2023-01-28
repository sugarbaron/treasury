//
//  CategoryDetailsAmountCard.swift
//  treasury
//
//  Created by sugarbaron on 04.08.2021.
//

import SwiftUI

extension CategoryDetails {
    
    struct AmountCard : View {
        
        private let name: String
        private let amount: Int
        
        init(_ name: String, _ amount: Int) {
            self.name = name
            self.amount = amount
        }
        
        var body: some View {
            VStack {
                Text(name).font(.title3)
                Text(verbatim: "\(amount)").font(.title2)
            }
            .frame(height: 55)
            .padding(.horizontal)
        }
        
    }
    
}

struct CategoryDetailsAmountCard_Previews : PreviewProvider {
    static var previews: some View {
        CategoryDetails.AmountCard("total", 1500)
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
