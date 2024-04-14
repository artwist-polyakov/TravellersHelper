//
//  СitiesView.swift
//  Rzhd
//
//  Created by Александр Поляков on 15.04.2024.
//

import SwiftUI

struct CitiesView: View {
    @Binding var path: [String]

    
    
    var body: some View {
        VStack {
            Text("Destination")
        }
        .navigationTitle("Выбор города")
                 .navigationBarBackButtonHidden(true)
                 .toolbar {
                     ToolbarItem(placement: .navigationBarLeading) {
                         Button(action: {
                             self.path.removeLast()
                         }) {
                             Image( "NavBackButton")
                                 .foregroundColor(Color.rzhdGreyBackButton)
                         }
                     }
                 }
    }
}

#Preview {
    CitiesView(path: .constant([]))
}
