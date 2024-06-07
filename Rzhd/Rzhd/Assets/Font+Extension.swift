//
//  Font+Extension.swift
//  Rzhd
//
//  Created by Александр Поляков on 07.06.2024.
//

import SwiftUI

extension Font {
    static var storyTitle: Font {
        Font.system(size: 34, weight: .bold)
    }

    static var storyText: Font {
        Font.system(size: 20, weight: .regular)
    }
}
