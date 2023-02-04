//
//  Di.swift
//  ios-x-gps-fleet
//
//  Created by Олег Мишкин on 28.07.2022.
//

import Foundation
import Swinject

public class Di {
    
    private let assembler: Assembler
    private let di: Resolver
    private let mutex: NSRecursiveLock
    
    public init(_ assemblages: [Swinject.Assembly]) {
        self.assembler = Assembler(assemblages)
        self.di = assembler.resolver
        self.mutex = .init()
    }
    
    // parameter is for ability to specify nullable type, for example:
    // guard let service: Service = Di.inject(Service?.self)
    // because if you try:
    // guard let service: Service = Di.inject()
    // generic parameter Type will be equal to Service, but not Optional<Service>
    public func inject<T:Nullable>(_ type: T.Type) -> T {
        mutex.lock()
        let instance: T = di.inject(type)
        mutex.unlock()
        return instance
    }
    
    public func inject<T:Nullable>(_ type: T.Type, for id: String) -> T {
        mutex.lock()
        let instance: T = di.inject(type, id: id)
        mutex.unlock()
        return instance
    }
    
    public func inject<T:Nullable, A>(_ type: T.Type, _ argument: A) -> T {
        mutex.lock()
        let instance: T = di.inject(type, argument: argument)
        mutex.unlock()
        return instance
    }
    
    public func inject<T:Nullable, A>(_ type: T.Type, for id: String, _ argument: A) -> T {
        mutex.lock()
        let instance: T = di.inject(type, id: id, argument: argument)
        mutex.unlock()
        return instance
    }

}

public extension Swinject.Container {

    @discardableResult
    func register<T : Nullable>(_ type: T.Type, _ constructInstance: @escaping () -> T) -> ServiceEntry<T> {
        register(type) { _ in constructInstance() }
    }
    
    func singleton<T : Nullable>(_ type: T.Type, _ constructInstance: @escaping () -> T) {
        register(type) { _ in constructInstance() }.inObjectScope(.container)
    }
    
    func singleton<T : Nullable>(_ type: T.Type, _ constructInstance: @escaping (Swinject.Resolver) -> T) {
        register(type) { constructInstance($0) }.inObjectScope(.container)
    }

}

public extension Swinject.Resolver {
    
    func inject<T:Nullable>(_ type: T.Type) -> T { resolve(type) ?? Log.nil("[Di] unable to resolve:[\(type)]") }
    
    func inject<T:Nullable>(_ type: T.Type, id: String) -> T {
        resolve(type, name: id) ?? Log.nil("[Di] unable to resolve:[\(type)] id:[\(id)]")
    }
    
    func inject<T:Nullable, A>(_ type: T.Type, argument: A) -> T {
        resolve(type, argument: argument) ?? Log.nil("[Di] unable to resolve:[\(type)] (a)")
    }
    
    func inject<T:Nullable, A>(_ type: T.Type, id: String, argument: A) -> T {
        resolve(type, name: id, argument: argument) ?? Log.nil("[Di] unable to resolve:[\(type)] id:[\(id)] (a)")
    }
    
}
