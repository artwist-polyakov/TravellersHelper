//
//  SettingsView.swift
//  Rzhd
//
//  Created by Александр Поляков on 12.04.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var path: [String]
    @EnvironmentObject var config: ThemeConfig
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                DarkThemeOption().environmentObject(config)
                AgreementOption()
                    .onTapGesture {
                        path.append("Agreement")
                    }
            }
        }.padding(.horizontal, 16).padding(.top, 68)
    }
}

#Preview {
    SettingsView( path: .constant([])
    ).environmentObject(ThemeConfig())
}
