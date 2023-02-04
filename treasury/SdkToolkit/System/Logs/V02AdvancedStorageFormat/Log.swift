//
//  Log.swift
//  ios-b2field
//
//  Created by sugarbaron on 18.11.2021.
//

import Foundation

public class Log {

    private static weak var engine: Engine? = nil

    public static func record(into storage: Log.Storage?) { engine?.record(into: storage) }

    @discardableResult
    public init(_ info: String, file: String = #file, method: String = #function, line: Int = #line) {
        Log.engine?.log(.info, info, file: file, method: method, line: line)
    }

    @discardableResult
    public init(error: String, file: String = #file, method: String = #function, line: Int = #line) {
        Log.engine?.log(.error, error, file: file, method: method, line: line)
    }

    @discardableResult
    public init(warning: String, file: String = #file, method: String = #function, line: Int = #line) {
        Log.engine?.log(.warning, warning, file: file, method: method, line: line)
    }

    internal static func constructEngine() -> Engine? {
        let engine: Engine = .init()
        Log.engine = engine
        return engine
    }

}

// MARK: log advanced
public extension Log {

    static func `nil`<T : Nullable>(_ diagnostics: String) -> T { Log(error: diagnostics); return nil }

}
