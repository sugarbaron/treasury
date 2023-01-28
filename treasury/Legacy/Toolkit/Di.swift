//
//  Di.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import Swinject

class Di {
    
    private let assembler: Assembler
    private let injector: Resolver

    init(_ assemblages: [Assembly]) {
        self.assembler = Assembler(assemblages)
        self.injector = assembler.resolver
    }
    
    // parameter is for ability to specify nullable type, for example:
    // let service: Service? = DI.inject(Service?.self)
    // because if you try:
    // let service: Service? = DI.inject()
    // generic parameter Type will be equal to Service, but not Optional<Service>
    func inject<Type>(_ type: Type.Type) throws -> Type { try injector.inject() }

}

extension Resolver {

    func inject<Type>() throws -> Type {
        guard let instance = resolve(Type.self) else { throw Exception("[Di] unable to resolve required type") }
        return instance
    }

}

extension ObjectScope {
    
    static let singleton = ObjectScope.container
    
}

extension ServiceEntry {
    
    func singleton() { inObjectScope(.singleton) }
    
}
