//
//  RegisterPurchaseViewModel.swift
//  treasury
//
//  Created by sugarbaron on 28.01.2023.
//

import SwiftUI
import Combine
import Bumblebee

// MARK: constructor
extension RegisterPurchase {
    
    final class ViewModel : ObservableObject {
        
        @ObservedObject var keyboard: DigitalKeyboard.Datastream
        @Published var available: Int
        @Published var displayed: Int
        
        private var subscriptions: [AnyCancellable]
        
        deinit { log("[RegisterPurchase.ViewModel] deallocating") }
        
        init() {
            log("[RegisterPurchase.ViewModel] reconstructing")
            let keyboard: DigitalKeyboard.Datastream = .init()
            self.keyboard = keyboard
            self.available = 100500
            self.displayed = keyboard.current
            self.subscriptions = [ ]
            
            keyboard.$entered
                .subscribe { log("[RegisterPurchase.ViewModel] entered:[\($0)]") }
                .store { subscriptions += $0 }
            keyboard.$current
                .subscribe { [weak self] in self?.watch(displayed: $0) }
                .store { subscriptions += $0 }
        }
        
    }
    
}

// MARK: interface

// MARK: tools
private extension RegisterPurchase.ViewModel {
    
    func watch(displayed: Int) {
        log("[RegisterPurchase.ViewModel] displayed:[\(displayed)]")
        self.displayed = displayed
        self.available = 100500 - displayed
    }
    
}

