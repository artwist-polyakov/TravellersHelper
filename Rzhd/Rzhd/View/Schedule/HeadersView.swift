//
//  HeaderView.swift
//  Rzhd
//
//  Created by Александр Поляков on 22.04.2024.
//

import SwiftUI

struct HeaderView: View {
    var header: String
    
    var body: some View {
        HStack {
            Text(header)
            .font(.system(size: 24, weight: .bold))
            Spacer()
        }
        .padding(.vertical, 16)
    }
}

#Preview {
    HeaderView(header: "Время отправления")
}
