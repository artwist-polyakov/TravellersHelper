//
//  UserDefaultsThemeRepository.swift
//  Rzhd
//
//  Created by Александр Поляков on 24.06.2024.
//

import Foundation

final class UserDefaultsThemeRepository: CurrentThemeRepository {
    static let shared = UserDefaultsThemeRepository()
    private let darkThemeKey = "darkThemeEnabled"
    
    func isDarkThemeEnabled() -> Bool {
        guard UserDefaults.standard.object(forKey: darkThemeKey) != nil else {
            return false
        }
        return UserDefaults.standard.bool(forKey: darkThemeKey)
    }
    
    func setDarkThemeEnabled(_ isEnabled: Bool) {
        UserDefaults.standard.set(isEnabled, forKey: darkThemeKey)
    }
}


