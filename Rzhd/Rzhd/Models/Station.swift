//
//  Station.swift
//  Rzhd
//
//  Created by Александр Поляков on 21.04.2024.
//

import Foundation

struct Station: Hashable, Identifiable {
    var id = UUID()
    var name: String
    var searchId: String?
}
