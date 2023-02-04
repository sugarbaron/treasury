//
//  Treasury.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import SwiftUI

@main
struct Treasury : App {
    
    init() { Starter.run() }
    
    var body: some Scene { WindowGroup { Categories.Screen() } }
    
}
