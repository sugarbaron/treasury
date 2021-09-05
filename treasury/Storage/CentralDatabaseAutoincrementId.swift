//
//  CentralDatabaseAutoincrementId.swift
//  treasury
//
//  Created by sugarbaron on 04.08.2021.
//

import Foundation


final class AutoincrementId {
    
    private var lastId: Int? = nil
    private let mutex: NSRecursiveLock = .init()
    
    func setLastId(_ lastId: Int?) { self.lastId = lastId }
    
    var next: Int {
        mutex.lock(); defer { mutex.unlock() }
        guard let lastId: Int = self.lastId else { self.lastId = 1; return 1 }
        let nextId: Int = lastId + 1
        self.lastId = nextId
        return nextId
    }
    
}

