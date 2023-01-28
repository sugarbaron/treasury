//
//  CentralStorageAssembly.swift
//  treasury
//
//  Created by sugarbaron on 25.07.2021.
//

import Swinject

extension CentralDatabase {
    
    final class Assembly : Swinject.Assembly {
        
        func assemble(container: Container) {
            container.singleton(CentralStorage?.self) { _ in CentralDatabase() }
        }
        
    }
    
}
