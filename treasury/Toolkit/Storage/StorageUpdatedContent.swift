//
//  StorageUpdatedContent.swift
//  treasury
//
//  Created by sugarbaron on 26.07.2021.
//

import CoreData

public final class Storage { }

public extension Storage {

    final class UpdatedContent<Entity:CoreDataConvertible> {
        
        private weak var controller: NSFetchedResultsController<CoreDataClass>? = nil
        
        public init(source controller: NSFetchedResultsController<Entity.CoreDataClass>) {
            self.controller = controller
        }
        
        public var entitiesCount: Int { controller?.fetchedObjects?.count ?? 0 }
        
        public var hasEntities: Bool { entitiesCount > 0 }
        
        public var sectionsCount: Int { controller?.sections?.count ?? 0 }
        
        public var hasSections: Bool { sectionsCount > 0 }
        
        public func entity(at index: IndexPath) -> Entity? {
            guard let sections: [NSFetchedResultsSectionInfo] = controller?.sections,
                  sections.indices.contains(index.section),
                  let section: [Any] = sections[index.section].objects,
                  section.indices.contains(index.item),
                  let coreDataEntity: CoreDataClass = section[index.item] as? CoreDataClass
            else { return nil }
            return Entity.construct(from: coreDataEntity)
        }
        
        public var entities: [Entity] {
            guard let coreDataObjects = controller?.fetchedObjects else { return [] }
            return coreDataObjects.compactMap { Entity.construct(from: $0) }
        }
        
        public func entities(at section: Int) -> [Entity] {
            guard let sections: [NSFetchedResultsSectionInfo] = controller?.sections,
                  sections.indices.contains(section),
                  let coreDataObjects = sections[section].objects as? [CoreDataClass]
            else { return [] }
            return coreDataObjects.compactMap { Entity.construct(from: $0) }
        }
        
        public func entitiesCount(at section: Int) -> Int { entities(at: section).count }
        
        public func sectionName(at section: Int) -> String? {
            guard let sections: [NSFetchedResultsSectionInfo] = controller?.sections,
                  sections.indices.contains(section)
            else { return nil }
            return sections[section].name
        }
        
        private typealias CoreDataClass = Entity.CoreDataClass
        
    }
    
}
