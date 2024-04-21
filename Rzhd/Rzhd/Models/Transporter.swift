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
    var logoUri: String
    
    
    func getLogo() -> Image {
        return Image.assetLogo(logoUri)
    }
    
    static func generateRandom() -> Transporter {
        let transporters = [
            Transporter(name: "Экспресс", logoUri: "Aeroexpress"),
            Transporter(name: "Фликс", logoUri: "Flixbus"),
            Transporter(name: "Поезд-корпорация", logoUri: "Poezd"),
            Transporter(name: "Сапсан", logoUri: "Sapsan"),
            Transporter(name: "Войяж", logoUri: "Voyage"),
            Transporter(name: "Яндекс", logoUri: "Yandex"),
            Transporter(name: "РЖД", logoUri: "RZHDLogo")
        ]
        return transporters.randomElement()!
    }
}
