//
//  DarkThemeUsecase.swift
//  Rzhd
//
//  Created by Александр Поляков on 24.06.2024.
//

import Foundation


final class DarkThemeUsecase: ObservableObject {
    let repository: CurrentThemeRepository = UserDefaultsThemeRepository.shared
    
    func isDarkThemeEnabled() -> Bool {
        return repository.isDarkThemeEnabled()
    }
    
    func interactWithTheme() -> Bool {
        let isEnabled = isDarkThemeEnabled()
        repository.setDarkThemeEnabled(!isEnabled)
        return !isEnabled
    }
}
