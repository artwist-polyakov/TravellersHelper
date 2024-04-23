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
    var name: String
    var bigLogoUri: String
    var email: String
    var phone: String
    
    func getLogo() -> Image {
        return Image.assetLogo(bigLogoUri)
    }
    
}
