//
//  Transporter.swift
//  Rzhd
//
//  Created by Александр Поляков on 21.04.2024.
//

import Foundation
import SwiftUI

struct Transporter: Hashable, Identifiable {
    var id = UUID()
    var name: String
    var logoUrl: URL? = nil
    
    
    static func generateRandom() -> Transporter {
        let transporters = [
            Transporter(name: "Экспресс"),
            Transporter(name: "Фликс"),
            Transporter(name: "Поезд-корпорация"),
            Transporter(name: "Сапсан"),
            Transporter(name: "Войяж"),
            Transporter(name: "Яндекс"),
            Transporter(name: "РЖД")
        ]
        return transporters.randomElement()!
    }
}
