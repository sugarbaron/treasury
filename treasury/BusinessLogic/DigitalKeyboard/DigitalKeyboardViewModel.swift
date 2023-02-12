//
//  DigitalKeyboardViewModel.swift
//  treasury
//
//  Created by sugarbaron on 12.02.2023.
//

import Combine

/// namespace class
struct DigitalKeyboard { }

// MARK: constructor
extension DigitalKeyboard {
    
    final class ViewModel : ObservableObject {
        
        @Published var keyTapped: KeyCode
        
        private var subscription: AnyCancellable?
        
        init() {
            self.keyTapped = .keyNone
            self.subscription = nil
            
            $keyTapped.subscribe { Log("[ViewModel] key:[\($0)]") }
                .store { subscription = $0 }
        }
        
    }
    
}

// MARK: interface
extension DigitalKeyboard {
    
    enum KeyCode {
        case key0
        case key1
        case key2
        case key3
        case key4
        case key5
        case key6
        case key7
        case key8
        case key9
        case keyDot
        case keyEnter
        case keyUndo
        case keyNone
    }
    
}
