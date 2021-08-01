//
//  Buttons.swift
//  treasury
//
//  Created by sugarbaron on 29.07.2021.
//

import SwiftUI

struct YesButton : View {
    
    var body: some View {
        CustomButton(image: "checkmark")
            .background(Colors.yellow)
            .cornerRadius(5)
    }
    
}

struct NoButton : View {
    
    var body: some View {
        CustomButton(image: "xmark")
            .background(Colors.red)
            .cornerRadius(5)
    }
    
}

struct CustomButton : View {
    
    private let name: String
    private let imageMode: Bool
    
    init(_ text: String) { self.name = text; self.imageMode = false }
    
    init(image: String) { self.name = image; self.imageMode = true }
    
    var body: some View {
        if (imageMode) {
            Image(systemName: name)
                .font(.title2)
                .foregroundColor(Colors.black)
                .padding()
        } else {
            Text(name)
                .font(.title2)
                .foregroundColor(Colors.black)
                .padding()
        }
    }
    
}
