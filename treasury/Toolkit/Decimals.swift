//
//  Decimals.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import Foundation

extension Decimal {
    
    var int: Int { NSDecimalNumber(decimal: self).intValue }
    
    var nsDecimal: NSDecimalNumber { NSDecimalNumber(decimal: self) }
    
}
