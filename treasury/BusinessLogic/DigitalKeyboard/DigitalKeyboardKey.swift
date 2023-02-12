//
//  DigitalKeyboardKey.swift
//  treasury
//
//  Created by sugarbaron on 11.02.2023.
//

import SwiftUI

extension DigitalKeyboard {
    
    struct Key<L:View> {
        
        let label: L
        
        init(_ label: L) { self.label = label }
        
    }
    
}

extension DigitalKeyboard.Key : View {
    
    var body: some View {
        Color.background
            .overlay(label)
            .border(Color.lowered, width: 3.0, rounded: 10.0)
            .onTap(effect: .border(color: .lowered, width: 4.0, rounded: 10.0)) {
                
            } onRelease: { Log("[Key] \($0)") }
    }
    
    private typealias Key = DigitalKeyboard.Key
    
}

struct DigitalKeyboardKey_Previews : PreviewProvider {
    static var previews: some View { DigitalKeyboard.Key(Text("5").title().foreground(.regular)) }
}
