//
//  Starter.swift
//  treasury
//
//  Created by sugarbaron on 28.01.2023.
//

import Bumblebee

final class Starter {
    
    static func run() {
        _ = Di.inject(Log.Engine?.self)
        log("[Starter] application started =============")
    }
    
}
