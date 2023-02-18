//
//  DigitalKeyboardKey.swift
//  treasury
//
//  Created by sugarbaron on 11.02.2023.
//

import SwiftUI

extension DigitalKeyboard.Ui {
    
    struct Key<L:View> {
        
        var code: DigitalKeyboard.KeyCode
        @Binding private var tapped: DigitalKeyboard.KeyCode
        
        private let label: L
        
        init(_ label: L, _ code: DigitalKeyboard.KeyCode, _ tapped: Binding<DigitalKeyboard.KeyCode>) {
            self.code = code
            self.label = label
            self._tapped = tapped
        }
        
    }
    
}

extension DigitalKeyboard.Ui.Key : View {
    
    var body: some View {
        Color.background
            .overlay(label)
            .border(Color.lowered, width: 3.0, rounded: 8.0)
            .onTap(effect: .border(color: .lowered, width: 5.0, rounded: 8.0)) { }
             onRelease: { if $0 == .confirmed { tapped = code } }
    }
    
    private typealias Key = DigitalKeyboard.Ui.Key
    
}

struct DigitalKeyboardKey_Previews : PreviewProvider {
    @State private static var key: DigitalKeyboard.KeyCode = .key5
    static var previews: some View { DigitalKeyboard.Ui.Key(Text("5").title().foreground(.regular), .key5, $key) }
}
