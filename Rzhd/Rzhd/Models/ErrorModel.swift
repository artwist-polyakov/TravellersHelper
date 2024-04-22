//
//  ErrorModel.swift
//  Rzhd
//
//  Created by Александр Поляков on 23.04.2024.
//

import Foundation
import SwiftUI


struct ErrorModel {
    
    let message: String
    let imageUri: String
    
    func getImage() -> Image {
        return Image.assetLogo(imageUri)
    }
    
    static func forState(_ state: ErrorStates) -> ErrorModel {
        switch state {
        case .noInternet:
            return ErrorModel(message: "Нет интернета", imageUri: "NoInternet")
        case .internalError:
            return ErrorModel(message: "Внутренняя ошибка", imageUri: "InternalError")
        }
    }
}

enum ErrorStates: Int {
    case noInternet = 0
    case internalError = 1
}
