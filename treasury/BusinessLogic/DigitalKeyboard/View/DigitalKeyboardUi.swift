//
//  DigitalKeyboardUi.swift
//  treasury
//
//  Created by sugarbaron on 04.02.2023.
//

import SwiftUI

// MARK: constructor
extension DigitalKeyboard {
    
    struct Ui {
        
        @StateObject private var viewModel: DigitalKeyboard.ViewModel
        
        init(_ datastream: DigitalKeyboard.Datastream) {
            Log("[DigitalKeyboard.Ui] reconstructing")
            self._viewModel = DigitalKeyboard.ViewModel(datastream).stateObject
        }
        
    }
    
}

// MARK: layout
extension DigitalKeyboard.Ui : View {
    
    var body: some View {
        VStack {
            Spacer()
            HStack { Spacer(); display; Spacer() }
            HStack { Spacer(); keys; Spacer() }
            Spacer()
        }
        .background(Color.uprised)
        .rounded(8)
    }
    
    private var display: some View {
        HStack { Spacer(); Text(viewModel.displayed.string).title().foreground(.regular).lineLimit(1).padding() }
            .background(Color.lowered)
            .border(Color.black, width: 3, rounded: 8)
    }
    
    private var keys: some View {
        KeysLayout {
            DigitKeysLayout {
                key("1", .key1); key("2", .key2); key("3", .key3)
                key("4", .key4); key("5", .key5); key("6", .key6)
                key("7", .key7); key("8", .key8); key("9", .key9)
                          key("0", .key0)
            }
            ControlKeysLayout {
                key(undo, .keyUndo)
                key(enter, .keyEnter)
            }
        }
    }
    
    private func key(_ label: String, _ code: KeyCode) -> some View {
        key(Text(label).title().foreground(.regular).lineLimit(1), code)
    }
    
    private func key(_ label: some View, _ code: KeyCode) -> some View {
        Key(label, code, $viewModel.keyTapped)
    }
    
    private var undo: some View {
        Image(systemName: "delete.left").title().foreground(.regular)
    }
    
    private var enter: some View {
        Image(systemName: "arrow.uturn.right").big().rotationEffect(.degrees(180)).foreground(.accent1)
    }
    
    private typealias KeyCode = DigitalKeyboard.KeyCode
}

struct DigitalKeyboard_Previews : PreviewProvider {
    static var previews: some View { DigitalKeyboard.Ui(.init()) }
}
