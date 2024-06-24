//
//  DarkThemeOption.swift
//  Rzhd
//
//  Created by Александр Поляков on 22.04.2024.
//

import SwiftUI

struct DarkThemeOption: View {
    @ObservedObject var viewModel: DarkThemeViewModel = DarkThemeViewModel.shared
    
    
    var body: some View {
        HStack (content: {
            Text("Темная тема")
                .font(.system(size:17))
            Spacer()
            Toggle(isOn: $viewModel.themeConfig.isDarkMode) {
            }
            .labelsHidden()
            .tint(.searchBackground).padding(.trailing, 8)
        }).frame(height: 60)
    }
}

#Preview {
    DarkThemeOption()
}
