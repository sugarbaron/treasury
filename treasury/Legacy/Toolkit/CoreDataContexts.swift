//
//  CoreDataContexts.swift
//  treasury
//
//  Created by sugarbaron on 25.07.2021.
//

import CoreData

extension NSManagedObjectContext {
    
    func saveChanges() {
        guard hasChanges else { return }
        try? save()
    }
    
}
