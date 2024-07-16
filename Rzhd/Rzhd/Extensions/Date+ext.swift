//
//  Date+ext.swift
//  Rzhd
//
//  Created by Александр Поляков on 21.04.2024.
//

import Foundation

struct DateParsingUtility {
    static let iso8601FormatterWithFractionalSeconds: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
    
    static let iso8601FormatterWithoutFractionalSeconds: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()
    
    static func parseISO8601Date(_ dateString: String?) -> Date? {
        guard let dateString = dateString else { return nil }
        if let date = iso8601FormatterWithFractionalSeconds.date(from: dateString) {
            return date
        }
        return iso8601FormatterWithoutFractionalSeconds.date(from: dateString)
    }
}

extension Date {
    func toNumberAndMonthRussian() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM"
        return dateFormatter.string(from: self)
    }
    
    func toTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
    func secsDelta(to other: Date) -> Int {
        return Int(other.timeIntervalSince(self))
    }
    
    static func fromISO8601String(_ string: String?) -> Date? {
        return DateParsingUtility.parseISO8601Date(string)
    }
}
