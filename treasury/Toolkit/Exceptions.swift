//
//  Exceptions.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import Foundation

public class Exception : Error {
    
    public init(_ cause: String = "") { Log(error: cause) }
    
}
