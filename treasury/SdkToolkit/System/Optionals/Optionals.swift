//
//  Optionals.swift
//  ios-b2field
//
//  Created by sugarbaron on 19.03.2021.
//

public func unwrap<T, R>(_ wrapped: T?, _ action: (T) -> R?, else: () -> R? = { nil }) -> R? {
    if let unwrapped: T = wrapped { return action(unwrapped) } else { return `else`() }
}

public func unwrap<T, R>(_ wrapped: T?, _ action: (T) throws -> R?, else: () throws -> R? = { nil }) rethrows -> R? {
    if let unwrapped: T = wrapped { return try action(unwrapped) } else { return try `else`() }
}

public typealias Nullable = ExpressibleByNilLiteral
