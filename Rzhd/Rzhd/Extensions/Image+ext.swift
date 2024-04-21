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
        let assetImage = Image(name)
        // Проверяем, можно ли загрузить UI изображение из ассетов
        if UIImage(named: name) != nil {
            return assetImage
        } else {
            // Возвращаем изображение-заполнитель
            return Image(systemName: "LogoPlaceholder")
        }
    }
}
