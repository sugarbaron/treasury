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
        
        @StateObject private var viewModel: DigitalKeyboard.ViewModel = .init()
        @EnvironmentObject private var datastream: DigitalKeyboard.Datastream
        
        init() { Log("[DigitalKeyboard.Ui] reconstructing") }
        
    }
    
}

// MARK: layout
extension DigitalKeyboard.Ui : View {
    
    var body: some View {
        keys
        .background(Color.uprised)
        .frame(minHeight: 220)
        .onAppear { viewModel.set(datastream) }
    }
    
    private var keys: some View {
        KeysLayout {
            DigitKeysLayout {
                key("7", .key7); key("8", .key8); key("9", .key9)
                key("4", .key4); key("5", .key5); key("6", .key6)
                key("1", .key1); key("2", .key2); key("3", .key3)
                                 key("0", .key0)
            }
            ControlKeysLayout {
                key(undo, .keyUndo)
                key(enter, .keyEnter)
            }
        }
    }
    
    private func key(_ label: String, _ code: KeyCode) -> some View {
        key(Text(label).design(size: .title), code)
    }
    
    private func key(_ label: some View, _ code: KeyCode) -> some View {
        Key(label, code, $viewModel.keyTapped)
    }
    
    private var undo: some View {
        Image(systemName: "delete.left").design(size: .title)
    }
    
    private var enter: some View {
        Image(systemName: "arrow.uturn.right").design(size: .large, color: .accent1).rotationEffect(.degrees(180))
    }
    
    private typealias KeyCode = DigitalKeyboard.KeyCode
}

struct DigitalKeyboard_Previews : PreviewProvider {
    static var previews: some View { DigitalKeyboard.Ui().environmentObject(DigitalKeyboard.Datastream()) }
}
