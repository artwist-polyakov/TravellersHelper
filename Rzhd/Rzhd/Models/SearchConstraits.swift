//
//  SearchConstraits.swift
//  Rzhd
//
//  Created by Александр Поляков on 22.04.2024.
//

import Foundation

struct SearchConstraits {
    var includingNight: Bool = true
    var includingMorning: Bool = true
    var includingDay: Bool = true
    var includingEvening: Bool = true
    var includingWithTransfer: Bool = true
    
    
    func isDefault() -> Bool {
        return includingNight &&
        includingMorning &&
        includingDay &&
        includingEvening &&
        includingWithTransfer
    }
    
}
