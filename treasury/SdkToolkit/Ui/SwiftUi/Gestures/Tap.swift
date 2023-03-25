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
        case border(color: Rgb = .black, line: CGFloat = 4, corners: CGFloat)
    }
    
}
