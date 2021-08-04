//
//  treasuryApp.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import SwiftUI

@main
struct treasuryApp: App {
    
    init() {
        let inspector: PlanningPeriodsInspector? = try? Di.inject(PlanningPeriodsInspector?.self)
        inspector?.start()
    }
    
    var body: some Scene {
        WindowGroup { Categories.Screen() }
    }
    
}
