//
//  DependencyInjection.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import Swinject

extension Di {
    
    static let di = Di(DiAssembly.assemblages)
    
    static func inject<Type>(_ type: Type.Type) throws -> Type { try di.inject(type) }
    
}

class DiToolkit {

    static let di = Di(DiAssembly.assemblages)

}

class DiAssembly : Assembly {

    fileprivate static let assemblages: [Assembly] = [
        DiAssembly(),
        CentralDatabase.Assembly()
    ]

    func assemble(container: Container) { container.register(Di.self) { _ in DiToolkit.di } }

}
