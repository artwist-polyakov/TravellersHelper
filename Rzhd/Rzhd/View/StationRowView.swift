//
//  StationRowView.swift
//  Rzhd
//
//  Created by Александр Поляков on 21.04.2024.
//

import SwiftUI

struct StationRowView: View {
    
    var station: Station
    
    var body: some View {
        HStack (content: {
            Text(station.name)
                .font(.system(size:17))
            Spacer()
            Image( "NavBackButton")
                .foregroundColor(Color.rzhdGreyBackButton)
                .rotationEffect(.degrees(180))
        }).frame(height: 60)
    }
}

#Preview {
    StationRowView(station: Station(name: "Тула-3"))
}
