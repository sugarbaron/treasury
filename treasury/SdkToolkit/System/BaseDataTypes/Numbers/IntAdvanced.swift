//
//  IntAdvanced.swift
//  ios-b2field
//
//  Created by sugarbaron on 19.11.2021.
//

import UIKit

public extension Int {

    var float: Float { .init(self) }

    var double: Double { .init(self) }

    var cgFloat: CGFloat { .init(self) }
    
    var string: String { "\(self)" }
    
    func restrict(_ range: Range<Int>) -> Int {
        if self < range.lowerBound { return range.lowerBound }
        if self > range.upperBound { return range.upperBound }
        return self
    }
    
    func restrict(_ range: ClosedRange<Int>) -> Int {
        if self < range.lowerBound { return range.lowerBound }
        if self > range.upperBound { return range.upperBound }
        return self
    }

}
