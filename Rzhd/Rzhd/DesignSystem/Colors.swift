//
//  Colors.swift
//  Rzhd
//
//  Created by Александр Поляков on 12.04.2024.
//

import SwiftUI

extension Color {
    
    init(uiColor: UIColor) {
             self.init(UIColor { _ in uiColor })
         }
    // Creates color from a hex string
    init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let alpha, red, green, blue: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(red) / 255,
            green: Double(green) / 255,
            blue: Double(blue) / 255,
            opacity: Double(alpha) / 255
        )
    }

    // Colors with dark mode
    static let ypBlackWithDarkMode = UIColor(named: "blackWithDarkMode") ?? UIColor.black
    static let ypWhiteWithDarkMode = UIColor(named: "whiteWithDarkMode") ?? UIColor.white
    static let ypLightGreyWithDarkMode = UIColor(named: "lightGreyWithDarkMode") ?? UIColor.lightGray

    // Universal colors
    static let searchBackground = Color(uiColor: UIColor(named: "SearchFieldBackground") ?? UIColor.systemGray6)
    static let greyColor =  Color(uiColor: UIColor(named: "RZHDGray") ?? UIColor.systemGray6)
    static let greyUniversal = UIColor(named: "RZHDGrayUniversal") ?? UIColor.gray
    static let ypBackground = UIColor(named: "background") ?? UIColor.systemBackground
    static let ypBlue = UIColor(named: "blue") ?? UIColor.blue
    static let ypBlackUniversal = UIColor(named: "blackUniversal") ?? UIColor.blue
    static let ypWhiteUniversal = UIColor(named: "whiteUniversal") ?? UIColor.white
    static let ypYellow = UIColor(named: "yellow") ?? UIColor.yellow
}
