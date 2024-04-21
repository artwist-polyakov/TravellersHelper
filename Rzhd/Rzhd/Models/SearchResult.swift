//
//  SearchResult.swift
//  Rzhd
//
//  Created by Александр Поляков on 21.04.2024.
//

import Foundation

struct SearchResult: Hashable, Identifiable {
    var id = UUID()
    var from: City
    var to: City
    var transporter: Transporter
    var departureTime: Date
    var arrivalTime: Date
    var price: Double
    
    static func generateRandom() -> SearchResult{
        let cities = [
            City(name: "Москва"),
            City(name: "Санкт-Петербург"),
            City(name: "Казань"),
            City(name: "Самара"),
            City(name: "Воронеж"),
            City(name: "Нижний Новгород"),
            City(name: "Владивосток"),
            City(name: "Сочи")
        ]
        
        return SearchResult (
            from: cities.randomElement()!,
            to: cities.randomElement()!,
            transporter: Transporter.generateRandom(),
            departureTime: Date() + TimeInterval.random(in: 0...100000),
            arrivalTime: Date() + TimeInterval.random(in: 100000...200000),
            price: Double.random(in: 1000...5000)
        )
    }
}