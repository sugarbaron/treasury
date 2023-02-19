//
//  DigitalKeyboard.swift
//  treasury
//
//  Created by sugarbaron on 18.02.2023.
//

import Combine

/// namespace class
final class DigitalKeyboard { }

extension DigitalKeyboard {
    
    final class Datastream : ObservableObject {
        
        @Published var current: Int
        @Published var entered: Int
        
        init(entered: Int = 0, current: Int = 0) {
            self.entered = entered
            self.current = current
        }
        
    }
    
}
