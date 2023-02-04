//
//  DictionaryAdvanced.swift
//  ios-b2field
//
//  Created by sugarbaron on 17.02.2022.
//

public extension Dictionary {

    var isNotEmpty: Bool { isEmpty == false }

    static func +=(lhs: inout [Key: Value], rhs: [Key: Value]) { rhs.forEach { lhs[$0] = $1 } }
    
}
