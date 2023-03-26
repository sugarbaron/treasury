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
        label
            .padding([.leading, .trailing])
            .padding([.top, .bottom], 5)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background.design(.border(.lowered, line: 2)).blur(radius: 1))
            .design(.border(.clear, line: 0))
            .button(effect: Design.depth) { tapped = code }
        
    }
    
    private typealias Key = DigitalKeyboard.Ui.Key
    
}

struct DigitalKeyboardKey_Previews : PreviewProvider {
    @State private static var key: DigitalKeyboard.KeyCode = .key5
    static var previews: some View { DigitalKeyboard.Ui.Key(Text("5").design(size: .title), .key5, $key) }
}
