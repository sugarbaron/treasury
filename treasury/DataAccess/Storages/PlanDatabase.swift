//
//  PlanDatabase.swift
//  treasury
//
//  Created by sugarbaron on 01.04.2023.
//

protocol PlanDatabase {
    
    func save(_ plan: Plan)
    
    func load() -> Plan?
    
}
