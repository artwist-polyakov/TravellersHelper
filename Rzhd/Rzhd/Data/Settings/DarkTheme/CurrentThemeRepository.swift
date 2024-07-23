//
//  File.swift
//  Rzhd
//
//  Created by Александр Поляков on 24.06.2024.
//

import Foundation


protocol CurrentThemeRepository {
    func isDarkThemeEnabled() -> Bool
    func setDarkThemeEnabled(_ isEnabled: Bool) -> Void
}
