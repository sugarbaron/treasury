//
//  Dates.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import Foundation

extension Date {
    
    static var now: Date { Date() }
    
    public static func parse(_ dateString: String,
                             template: String = "yyyy-MM-dd HH:mm:ss",
                             timeZone: TimeZoneId = .utc) throws -> Date {
        return try parse(dateString, template: template, timeZone: timeZone.secondsFromGMT)
    }
    
    private static func parse(_ dateString: String,
                                template: String = "yyyy-MM-dd HH:mm:ss",
                                timeZone secondsFromGMT: Int) throws -> Date {
        let converter = DateFormatter.with(template, secondsFromGMT)
        guard let date = converter.date(from: dateString) else {
            throw Exception("unable to parse:[\(dateString)] as:[\(template)]")
        }
        return date
    }
    
    public var string: String { formatDate(as: "yyyy-MM-dd HH:mm:ss", timeZone: TimeZoneId.current.secondsFromGMT) }
    
    public var shortDay: String { formatDate(as: "dd.MM", timeZone: TimeZoneId.current.secondsFromGMT) }
    
    public func format(as template: String = "yyyy-MM-dd HH:mm:ss", timeZone: TimeZoneId = .utc) -> String {
        return formatDate(as: template, timeZone: timeZone.secondsFromGMT)
    }
    
    private func formatDate(as template: String, timeZone secondsFromGMT: Int) -> String {
        let converter = DateFormatter.with(template, secondsFromGMT)
        return converter.string(from: self)
    }
    
    public enum TimeZoneId {
        case current
        case utc
        
        var secondsFromGMT: Int {
            switch self {
            case .utc:     return 0
            case .current: return TimeZone.current.secondsFromGMT()
            }
        }
        
    }
    
}

extension Date : ExpressibleByStringLiteral {
    
    static let invalid: Date = .init(timeIntervalSince1970: 0)
    
    /** template is "yyyy-MM-dd HH:mm:ss" */
    public init(stringLiteral value: String) {
        if let date: Date = try? Date.parse(value) { self = date }
        else { Log(error: "[Date] wrong format:[\(value)] need:[yyyy-MM-dd HH:mm:ss]"); self = Date.invalid }
    }
    
}

extension DateFormatter {
    
    public static func with(_ template: String, _ secondsFromGmt: Int) -> DateFormatter {
        create(template, secondsFromGmt)
    }
    
    private static func create(_ template: String, _ secondsFromGmt: Int) -> DateFormatter {
        let converter = DateFormatter()
        converter.dateFormat = template
        converter.locale = Locale(identifier: "en_US_POSIX")
        converter.calendar = Calendar(identifier: .iso8601)
        converter.timeZone = TimeZone(secondsFromGMT: secondsFromGmt)
        return converter
    }

}
