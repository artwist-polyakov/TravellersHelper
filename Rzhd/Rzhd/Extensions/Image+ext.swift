//
//  Image+ext.swift
//  Rzhd
//
//  Created by Александр Поляков on 21.04.2024.
//

import Foundation
import SwiftUI
extension Image {
    static func assetLogo(_ name: String) -> Image {
        // Попытка загрузить изображение из ассетов
        if let _ = UIImage(named: name) {
            // Загружаем изображение, если оно существует
            return Image(name)
        } else {
            // Возвращаем изображение-заполнитель
            return Image("LogoPlaceholder")
        }
    }
}
