//
//  CategoryFields.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

extension CoreDataCategory : CoreDataEntity { public static let entityName: String = "Category" }

final class CategoryFields {

    static let id = "id"
    static let name: String = "name"
    static let plan: String = "plan"
    static let fact: String = "fact"
    static let periodId: String = "periodId"
    
}


