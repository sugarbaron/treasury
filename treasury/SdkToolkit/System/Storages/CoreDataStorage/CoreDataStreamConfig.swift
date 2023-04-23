//
//  CoreDataStreamConfig.swift
//  treasury
//
//  Created by sugarbaron on 22.04.2023.
//

public extension CoreDataStorage.DataStream {
    
    final class Config {
        
        public let predicate: Predicate
        public let sort: [Sort]
        public let sectionKey: String?
        
        public init(_ predicate: Predicate, sort: [Sort] = [ ], sectionKey: String? = nil) {
            self.predicate = predicate
            self.sort = sort
            self.sectionKey = sectionKey
        }
        
    }
    
}
