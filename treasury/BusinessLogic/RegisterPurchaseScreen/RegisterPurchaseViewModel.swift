//
//  RegisterPurchaseViewModel.swift
//  treasury
//
//  Created by sugarbaron on 28.01.2023.
//

import SwiftUI
import Combine

// MARK: constructor
extension RegisterPurchase {
    
    final class ViewModel : ObservableObject {
        
        @ObservedObject var keyboard: DigitalKeyboard.Datastream
        
        private var subscriptions: [AnyCancellable]
        
        deinit { Log("[RegisterPurchase.ViewModel] deallocating") }
        
        init() {
            Log("[RegisterPurchase.ViewModel] reconstructing")
            self.keyboard = DigitalKeyboard.Datastream()
            self.subscriptions = [ ]
            
            keyboard.$entered
                .subscribe { Log("[RegisterPurchase.ViewModel] entered:[\($0)]") }
                .store { subscriptions += $0 }
            keyboard.$displayed
                .subscribe { Log("[RegisterPurchase.ViewModel] displayed:[\($0)]") }
                .store { subscriptions += $0 }
        }
        
    }
    
}

// MARK: interface

// MARK: tools
