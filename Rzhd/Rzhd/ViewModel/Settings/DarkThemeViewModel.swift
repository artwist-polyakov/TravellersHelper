//
//  DarkThemeViewModel.swift
//  Rzhd
//
//  Created by Александр Поляков on 24.06.2024.
//

import Foundation

@MainActor
final class DarkThemeViewModel:  ObservableObject {
    static let shared = DarkThemeViewModel()
    private let themeUseCase = DarkThemeUsecase()
    @Published var themeConfig: ThemeConfig = ThemeConfig()
    
    init() {
        themeConfig.isDarkMode = themeUseCase.isDarkThemeEnabled()
    }
    
    func toggleTheme() -> Void {
        themeConfig.isDarkMode = themeUseCase.interactWithTheme()
    }
}
