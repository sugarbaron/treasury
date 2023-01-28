//
//  TreasuryDateAdvanced.swift
//  treasury
//
//  Created by sugarbaron on 28.01.2023.
//

import Foundation

extension Date {
    
    var ddMM: String { self.as("dd.MM", timeZone: .current) }
    var ddMMyyyy: String { self.as("dd.MM.yyyy", timeZone: .current) }
    
}
