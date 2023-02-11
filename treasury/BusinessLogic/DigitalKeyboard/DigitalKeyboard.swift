//
//  DigitalKeyboard.swift
//  treasury
//
//  Created by sugarbaron on 04.02.2023.
//

import SwiftUI

// MARK: constructor
struct DigitalKeyboard { }

// MARK: layout
extension DigitalKeyboard : View {
    
    var body: some View {
        VStack {
            Spacer()
            HStack { Spacer(); display; Spacer() }
            HStack { Spacer(); keys; Spacer() }
            Spacer()
        }
        .background(Color.uprised)
        .rounded(10)
    }
    
    private var display: some View {
        HStack { Spacer(); Text("100500").title().foreground(.regular).lineLimit(1).padding() }
            .background(Color.lowered)
            .border(Color.black, width: 2, rounded: 10)
    }
    
    private var keys: some View {
        KeysLayout {
            DigitKeysLayout {
                key("1"); key("2"); key("3")
                key("4"); key("5"); key("6")
                key("7"); key("8"); key("9")
                          key("0")
            }
            ControlKeysLayout {
                key(undo)
                key(".")
                key(enter)
            }
        }
    }
    
    private func key(_ label: String) -> some View {
        key(Text(label).title().foreground(.regular).lineLimit(1))
    }
    
    private func key(_ label: some View) -> some View { Key(label) }
    
    private var undo: some View {
        Image(systemName: "delete.left").title().foreground(.regular)
    }
    
    private var enter: some View {
        Image(systemName: "arrow.uturn.right").big().rotationEffect(.degrees(180)).foreground(.accent1)
    }
}

struct DigitalKeyboard_Previews : PreviewProvider {
    static var previews: some View { DigitalKeyboard() }
}
