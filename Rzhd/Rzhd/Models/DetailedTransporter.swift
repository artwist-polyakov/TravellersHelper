//
//  DetailedTransporter.swift
//  Rzhd
//
//  Created by Александр Поляков on 22.04.2024.
//

import Foundation
import SwiftUI

struct DetailedTransporter: Hashable, Identifiable {
    var id = UUID()
    var name: String = "Неизвестный перевозчик"
    var bigLogoUri: URL? = nil
    var email: String? = nil
    var phone: String? = nil
}
