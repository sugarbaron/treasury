//
//  ResourcesColor.swift
//  treasury
//
//  Created by sugarbaron on 29.01.2023.
//

public extension Resources {
    
    // template is 0xrrggbbaa
    @dynamicMemberLookup
    enum Color : Rgb, CaseIterable {
        case red      = 0xEC652B00
        case red01    = 0xFF000000
        case orange   = 0xE8833100
        case orange01 = 0xFF7F0000
        case yellow   = 0xF7CE4600
        case yellow01 = 0xFFDD0000
        case green    = 0x66BD5200
        case green01  = 0x00FF0000
        case green02  = 0x00800000
        case green03  = 0x00968800
        case blue     = 0x0087CC00
        case blue01   = 0x2566AC00
        case blue02   = 0x10488A00
        case blue03   = 0x03A9F400
        case blue04   = 0x0088BB00
        case biege    = 0xD7CCAA00
        case biege01  = 0xA6A18000
        case biege02  = 0xFFC66D00
        case purple   = 0x906FEE00
        case purple01 = 0x9000FF00
        case gray     = 0x40404000
        case gray01   = 0x2B2B2B00
        case gray02   = 0xC3C3C300
        case unknown  = 0xE91E6300
        
        public init(_ hex: Int) { self = unwrap(Color(rawValue: hex.rgb)) { $0 } ?? .unknown }
        
        public subscript<T>(dynamicMember field: KeyPath<Rgb, T>) -> T { rawValue[keyPath: field] }
        
        var rgb: Rgb { rawValue }
        
    }
    
}
