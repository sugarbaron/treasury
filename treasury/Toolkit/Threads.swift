//
//  Threads.swift
//  treasury
//
//  Created by sugarbaron on 04.08.2021.
//

import Foundation

final class Threads {
    
    static func runOnMain(_ code: @escaping () -> Void) { OperationQueue.main.addOperation { code() } }
    
}

extension OperationQueue {
    
    public static func newSerial() -> OperationQueue {
        let serial = OperationQueue()
        serial.maxConcurrentOperationCount = 1
        return serial
    }
    
    public func addCancellable(_ action: @escaping ((() -> Bool) -> Void)) {
        let operation = ManualCancellableOperation(action)
        addOperation(operation)
    }

}

private class ManualCancellableOperation : Operation {
    
    private var action: ((() -> Bool) -> Void)? = nil
    
    convenience init(_ action: @escaping ((() -> Bool) -> Void)) {
        self.init()
        self.action = action
    }

    override func main() {
        guard !(isCancelled) else { return }
        action?({ [weak self] in self?.isCancelled ?? true })
    }
    
}
