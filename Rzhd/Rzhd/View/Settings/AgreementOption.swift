//
//  AgreementOption.swift
//  Rzhd
//
//  Created by Александр Поляков on 22.04.2024.
//

import SwiftUI

struct AgreementOption: View {
    var body: some View {
        HStack (content: {
            Text("Пользовательское соглашение")
                .font(.system(size:17))
            Spacer()
            Image( "NavBackButton")
                .foregroundColor(Color.rzhdGreyBackButton)
                .rotationEffect(.degrees(180))
        }).frame(height: 60)
    }
}

#Preview {
    AgreementOption()
}
