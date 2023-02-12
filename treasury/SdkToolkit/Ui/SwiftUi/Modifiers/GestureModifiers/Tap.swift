//
//  Tap.swift
//  treasury
//
//  Created by sugarbaron on 12.02.2023.
//

import SwiftUI

/// namespace class
public final class Tap {  }

public extension Tap {
    
    enum Confirmation { case confirmed; case rejected }
    
    enum Effect {
        case scale
        case border(color: Rgb = .black ,width: CGFloat = 2.0, rounded: CGFloat = 0.0)
        
        public typealias Border = (color: Rgb, width: CGFloat, rounded: CGFloat)
    }
    
}
