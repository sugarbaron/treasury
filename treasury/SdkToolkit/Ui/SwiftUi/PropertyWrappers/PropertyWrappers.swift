//
//  PropertyWrappers.swift
//  ios-x-gps-fleet
//
//  Created by sugarbaron on 31.01.2023.
//

import SwiftUI

public extension ObservableObject {
    
    var stateObject: StateObject<Self> { .init(wrappedValue: self) }
    
}

public extension State { var wrapped: Value { wrappedValue } }

public extension Binding { var wrapped: Value { wrappedValue } }

public extension ObservedObject { var wrapped: ObjectType { wrappedValue } }

public extension StateObject { var wrapped: ObjectType { wrappedValue } }
