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
        
        @Published var entered: Int
        @Published var displayed: Int
        
        init(entered: Int = 0, displayed: Int = 0) {
            self.entered = entered
            self.displayed = displayed
        }
        
    }
    
}
