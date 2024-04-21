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
}
