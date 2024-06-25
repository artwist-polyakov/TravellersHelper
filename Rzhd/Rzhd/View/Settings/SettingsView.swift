//
//  SettingsView.swift
//  Rzhd
//
//  Created by Александр Поляков on 12.04.2024.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var router: PathRouter = PathRouter.shared
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(spacing: 0) {
                    DarkThemeOption()
                    AgreementOption()
                        .onTapGesture {
                            router.pushPath(.agreement)
                        }
                }
            }
            VStack {
             Spacer()
            Text("Приложение использует API «Яндекс.Расписания» \n \n Версия 1.0 (beta)")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 12))
                    .padding(.bottom, 24)
            }
        }.padding(.horizontal, 16).padding(.top, 68)
            .background(Color.colorPrimary.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    SettingsView()
}
