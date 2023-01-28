//
//  DependencyInjection.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import Swinject

extension Di {
    
    static func inject<T:Nullable>(_ type: T.Type) -> T { di.inject(type) }

    static func inject<T:Nullable>(_ type: T.Type, for id: String) -> T {
        di.inject(type, for: id)
    }
    
    static func inject<T:Nullable, A>(_ type: T.Type, _ argument: A) -> T {
        di.inject(type, argument)
    }
    
    static func inject() -> Di { di }
    
    private static let di: Di = .init([
        DiAssembly(),
        Log.Assembly(),
        /* fixme: legacy */
        CentralDatabase.Assembly(),
        PlanningPeriodsInspector.Assembly()
    ])
    
}

class DiAssembly : Assembly {

    func assemble(container: Container) { container.register(Di?.self) { Di.inject() } }

}
