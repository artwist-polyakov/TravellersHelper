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
}
