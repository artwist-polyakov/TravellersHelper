//
//  AgreementView.swift
//  Rzhd
//
//  Created by Александр Поляков on 23.04.2024.
//

import SwiftUI

struct AgreementView: View {
    
    @Binding var path: [NavigationIdentifiers]
    
    var body: some View {
        WebView(url: URL(string: "https://yandex.ru/legal/practicum_offer/?ysclid=lvbglg2my2169602491")!).navigationTitle("Пользовательское соглашение").navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        if !self.path.isEmpty{
                            self.path.removeLast()}
                    }) {
                        Image( "NavBackButton")
                            .foregroundColor(Color.rzhdGreyBackButton)
                    }
                }
            }
    }
}

#Preview {
    AgreementView( path: .constant([]))
}
