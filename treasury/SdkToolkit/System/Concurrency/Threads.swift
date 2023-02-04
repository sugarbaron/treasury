//
//  Threads.swift
//  ios-x-gps-fleet
//
//  Created by Олег Мишкин on 08.06.2021.
//

import Foundation

public class Threads {

    public static func runOnMain(_ code: @escaping () -> Void) { OperationQueue.main.addOperation { code() } }

    public static func runOnMain(afterDelay delay: TimeInterval, _ code: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { code() }
    }

}

public extension Thread {

    static var isMain: Bool { Thread.isMainThread }

    static func sleep(_ duration: TimeInterval) { sleep(forTimeInterval: duration) }

}
