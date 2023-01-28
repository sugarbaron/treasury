//
//  FetchRequest.swift
//  treasury
//
//  Created by sugarbaron on 25.07.2021.
//

import CoreData

public class FetchRequest<Entity:CoreDataEntity> : NSObject {
    
    private var context: NSManagedObjectContext
    
    private var request = NSFetchRequest<Entity>()
    
    public init(_ context: NSManagedObjectContext,
                predicate: NSPredicate = NSPredicate(value: true),
                sort: [NSSortDescriptor] = [],
                limit: Int? = nil) {
        
        self.context = context
        request.entity = NSEntityDescription.entity(forEntityName: Entity.entityName, in: context)
        request.predicate = predicate
        request.sortDescriptors = sort
        if let limit = limit { request.fetchLimit = limit }
        request.returnsObjectsAsFaults = false
    }

    public func execute() -> [Entity] { (try? request.execute()) ?? [] }
    
}
