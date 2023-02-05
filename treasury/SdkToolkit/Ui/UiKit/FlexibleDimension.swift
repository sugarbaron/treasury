//
//  FlexibleDimension.swift
//  treasury
//
//  Created by sugarbaron on 04.02.2023.
//

import Foundation

// MARK: constructor
public final class FlexibleDimension {
    
    public let `try`: CGFloat?
    public let min: CGFloat?
    public let max: CGFloat?
    
    public init(try: CGFloat? = nil, min: CGFloat? = nil, max: CGFloat? = nil) {
        self.try = `try`
        self.min = min
        self.max = max
    }
    
    static func flexible(try: CGFloat? = nil, min: CGFloat? = nil, max: CGFloat? = nil) -> FlexibleDimension {
        .init(try: `try`, min: min, max: max)
    }
    
    static let any: FlexibleDimension = .init(try: nil, min: nil, max: nil)
    
}

// MARK: contributions
public extension CGFloat {
    
    func flexible(min: CGFloat? = nil, max: CGFloat? = nil) -> FlexibleDimension {
        .init(try: self, min: min, max: max)
    }
    
}

public extension Double {
    
    var flexible: FlexibleDimension { .init(try: CGFloat(self)) }
    
}
