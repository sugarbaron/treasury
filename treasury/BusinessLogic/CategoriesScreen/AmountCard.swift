//
//  AmountCard.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import SwiftUI

struct AmountCard : View {
    
    let name: String
    let amount: Int
    
    init(_ name: String, _ amount: Int) {
        self.name = name
        self.amount = amount
    }
    
    var body: some View {
        VStack {
            Text(name)
            Text("\(amount)")
        }.padding()
        //.background(Color.green)
    }
    
}

struct AmountCard_Previews : PreviewProvider {
    static var previews: some View {
        AmountCard("dinners", 1500)
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
