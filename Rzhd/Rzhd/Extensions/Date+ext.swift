//
//  Date+ext.swift
//  Rzhd
//
//  Created by Александр Поляков on 21.04.2024.
//

import Foundation

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
}
