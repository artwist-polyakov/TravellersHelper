//
//  DarkThemeOption.swift
//  Rzhd
//
//  Created by Александр Поляков on 22.04.2024.
//

import SwiftUI

struct DarkThemeOption: View {
    @EnvironmentObject var config: ThemeConfig
    
    
    
    var body: some View {
        HStack (content: {
            Text("Темная тема")
                .font(.system(size:17))
            Spacer()
            Toggle(isOn: $config.isDarkMode) {
            }
            .labelsHidden()
            .tint(.searchBackground)
        }).frame(height: 60)
    }
}

#Preview {
    DarkThemeOption().environmentObject(ThemeConfig())
}
