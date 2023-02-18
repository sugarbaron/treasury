//
//  DigitalKeyboardViewModel.swift
//  treasury
//
//  Created by sugarbaron on 12.02.2023.
//

import SwiftUI
import Combine

// MARK: constructor
extension DigitalKeyboard {
    
    final class ViewModel : ObservableObject {
        
        @Published var keyTapped: KeyCode
        @Published var displayed: Int
        
        private var amount: Int
        private var datastream: DigitalKeyboard.Datastream
        private var subscriptions: [AnyCancellable]
        
        deinit { Log("[DigitalKeyboard.ViewModel] deallocating") }
        
        init(_ datastream: DigitalKeyboard.Datastream) {
            Log("[DigitalKeyboard.ViewModel] reconstructing")
            self.keyTapped = .keyNone
            self.displayed = datastream.displayed
            self.amount = datastream.displayed
            self.datastream = datastream
            self.subscriptions = [ ]
            
            $keyTapped
                .subscribe { [weak self] in self?.react(to: $0) }
                .store { subscriptions += $0 }
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
        case keyEnter
        case keyUndo
        case keyNone
    }
    
}

// MARK: tools
private extension DigitalKeyboard.ViewModel {
    
    func react(to key: DigitalKeyboard.KeyCode) {
        switch key {
        case .keyNone:  break
        case .keyEnter: reactToEnter()
        case .keyUndo:  reactToUndo()
        default:        reactTo(digit: key)
        }
    }
    
    func reactToEnter() {
        datastream.entered = amount
        amount = 0
        display()
    }
    
    func reactToUndo() { amount /= 10; display() }
    
    func reactTo(digit key: DigitalKeyboard.KeyCode) {
        guard amount < ((Int.max - 10) / 10) else { return }
        amount *= 10
        switch key {
        case .key0: amount += 0
        case .key1: amount += 1
        case .key2: amount += 2
        case .key3: amount += 3
        case .key4: amount += 4
        case .key5: amount += 5
        case .key6: amount += 6
        case .key7: amount += 7
        case .key8: amount += 8
        case .key9: amount += 9
        default: return
        }
        display()
    }
    
    func display() { displayed = amount; datastream.displayed = amount }
    
}
