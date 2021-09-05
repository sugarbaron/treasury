//
//  CentralStorage.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import Foundation

protocol CentralStorage {
    
    var categories: CategoriesStorage { get }
    
    var purchases: PurchasesStorage { get }
    
    var periods: PlanningPeriodsStorage { get }
    
    var income: IncomeStorage { get }
    
}
