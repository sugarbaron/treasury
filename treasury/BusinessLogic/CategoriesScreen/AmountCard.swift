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
    private let highlight: Color
    
    init(_ name: String, _ amount: Int, _ color: Color = Colors.black) {
        self.name = name
        self.amount = amount
        self.highlight = color
    }
    
    var body: some View {
        VStack {
            Text(name)
                .font(.title3)
            Text(verbatim: "\(amount)")
                .font(.title)
                .bold()
                .foregroundColor(highlight)
                
        }
        .padding()
        //.background(Color.green)
    }
    
}

struct AmountCard_Previews : PreviewProvider {
    static var previews: some View {
        AmountCard("total", 1500, Colors.green)
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
