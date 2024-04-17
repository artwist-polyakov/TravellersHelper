//
//  CityRowView.swift
//  Rzhd
//
//  Created by Александр Поляков on 17.04.2024.
//

import SwiftUI

struct CityRowView: View {
    
    var city: City
    
    var body: some View {
        HStack (content: {
            Text(city.name)
                .font(.system(size:17))
            Spacer()
            Image( "NavBackButton")
                .foregroundColor(Color.rzhdGreyBackButton)
                .rotationEffect(.degrees(180))
        }).frame(height: 60)
    }
}

#Preview {
    CityRowView(city: City(name: "Москва"))
}
