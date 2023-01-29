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
        case red      = 0xEC652BFF
        case red01    = 0xFF0000FF
        case orange   = 0xE88331FF
        case orange01 = 0xFF7F00FF
        case yellow   = 0xF7CE46FF
        case yellow01 = 0xFFDD00FF
        case green    = 0x66BD52FF
        case green01  = 0x00FF00FF
        case green02  = 0x008000FF
        case green03  = 0x009688FF
        case blue     = 0x0087CCFF
        case blue01   = 0x2566ACFF
        case blue02   = 0x10488AFF
        case blue03   = 0x03A9F4FF
        case blue04   = 0x0088BBFF
        case biege    = 0xD7CCAAFF
        case biege01  = 0xA6A180FF
        case biege02  = 0xFFC66DFF
        case purple   = 0x906FEEFF
        case purple01 = 0x9000FFFF
        case gray     = 0x404040FF
        case gray01   = 0x2B2B2BFF
        case gray02   = 0xC3C3C3FF
        case gray03   = 0xD0D0D0FF
        case gray04   = 0xDFDFDFFF
        case gray05   = 0xE0E0E0FF
        case white    = 0xFFFFFFFF
        case black    = 0x000000FF
        case unknown  = 0xE91E63FF
        
        public init(_ hex: Int) { self = unwrap(Color(rawValue: hex.rgb)) { $0 } ?? .unknown }
        
        public subscript<T>(dynamicMember field: KeyPath<Rgb, T>) -> T { rawValue[keyPath: field] }
        
        var rgb: Rgb { rawValue }
        
    }
    
}
