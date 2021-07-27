//
//  AmountCard.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import SwiftUI

struct AmountCard : View {
    
    private let name: String
    private let amount: Int
    
    init(_ name: String, _ amount: Int) {
        self.name = name
        self.amount = amount
    }
    
    var body: some View {
        VStack {
            Text(name)
                .font(.title3)
            Text(verbatim: "\(amount)")
                .font(.title2)
        }
        .padding()
    }
    
}

struct AmountCard_Previews : PreviewProvider {
    static var previews: some View {
        AmountCard("total", 1500)
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
