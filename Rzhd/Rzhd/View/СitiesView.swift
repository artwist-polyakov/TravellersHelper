//
//  СitiesView.swift
//  Rzhd
//
//  Created by Александр Поляков on 15.04.2024.
//

import SwiftUI

struct CitiesView: View {
    @Binding var path: [String]
    @State private var searchText: String = ""
    
    
    var body: some View {
        VStack {
            
            HStack {
                
                // Иконка лупы слева
                Image(systemName: "magnifyingglass")
                    .foregroundColor(searchText.isEmpty ? .gray : .black)
                    .padding(.leading, 8)
                TextField("Введите запрос", text: $searchText)
                     // Явно указываем высоту поля
                    .padding(.vertical, 8)
                if !searchText.isEmpty {
                    Button(action: {
                        self.searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 6)
                }
            }
            .background(Color.rzhdGray)
            .cornerRadius(10)
            .frame(height: 36)
            
            Spacer()
            Text("Destination")
            Spacer()
        }.padding(.horizontal, 16)
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
