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
        @State var scale: CGFloat = Scale.original
        @State var shading: CGFloat = Shading.original
        
        init(_ label: L) { self.label = label }
        
    }
    
}

extension DigitalKeyboard.Key : View {
    
    var body: some View {
        Color.background
            .overlay(label)
            .border(Color.lowered, width: 3, rounded: 10)
            .overlay(Color.black.opacity(shading))
            .scaleEffect(scale)
            .onTap {
                scale = Scale.tapped
                shading = Shading.tapped
            } onRelease: { 
                Log("[Key] \($0)")
                withAnimation(.linear(duration: 0.07)) {
                    scale = Scale.original
                    shading = Shading.original
                }
            }
    }
    
    private typealias Key = DigitalKeyboard.Key
    
}

private final class Scale {
    static let original: CGFloat = 1.0
    static let tapped: CGFloat = 0.96
}

private final class Shading {
    static let original: CGFloat = 0.0
    static let tapped: CGFloat = 0.1
}

struct DigitalKeyboardKey_Previews : PreviewProvider {
    static var previews: some View { DigitalKeyboard.Key(Text("5").title().foreground(.regular)) }
}
