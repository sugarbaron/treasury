//
//  Unwrap.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//


@discardableResult
func unwrap<T, R>(_ wrapped: T?, _ action: (T) -> R) -> R? {
    if let unwrapped = wrapped { return action(unwrapped) } else { return nil }
}

@discardableResult
func unwrap<T, R>(_ wrapped: T?, _ action: (T) -> R?) -> R? {
    if let unwrapped = wrapped { return action(unwrapped) } else { return nil }
}
