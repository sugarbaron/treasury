//
//  IncomeFields.swift
//  treasury
//
//  Created by sugarbaron on 05.09.2021.
//

extension CoreDataIncome : CoreDataEntity { public static let entityName: String = "Income" }

final class IncomeFields {
    
    static let id: String = "id"
    static let amount: String = "amount"
    static let date: String = "date"
    static let comment: String = "comment"
    
}
