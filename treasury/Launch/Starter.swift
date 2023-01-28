//
//  Starter.swift
//  treasury
//
//  Created by sugarbaron on 28.01.2023.
//

final class Starter {
    
    static func run() {
        _ = Di.inject(Log.Engine?.self)
        Log("[Starter] application started =============")
        startPlanningPeriodsInspector()
    }
    
    private static func startPlanningPeriodsInspector() {
        let inspector: PlanningPeriodsInspector? = Di.inject(PlanningPeriodsInspector?.self)
        inspector?.start()
    }
    
}
