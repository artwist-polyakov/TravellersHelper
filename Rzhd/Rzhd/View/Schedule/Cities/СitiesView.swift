//
//  СitiesView.swift
//  Rzhd
//
//  Created by Александр Поляков on 15.04.2024.
//

import SwiftUI

struct CitiesView: View {
    @EnvironmentObject var searchData: SearchData
    
    @Binding var path: [String]
    @State private var searchText: String = ""
    @StateObject var viewModel = CitiesViewModel()
    
    func proceedCityName(city: City) {
        if ($path.isEmpty) {
            return
        }
        switch searchData.currentlySelectedTextField {
        case .from:
            searchData.cityFrom = city
        case .to:
            searchData.cityTo = city
        case .nothing:
            break
        }
        self.path.append("StationsList")
    }
    
    var body: some View {
        
        VStack {
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(searchText.isEmpty ? .gray : .black)
                    .padding(.leading, 8)
                TextField("Введите запрос", text: $searchText) .onChange(of: searchText) { newValue in
                    viewModel.onTextChanged(newValue)
                }
                .padding(.vertical, 8)
                if !searchText.isEmpty {
                    Button(action: {
                        self.searchText = ""
                        viewModel.onTextChanged(self.searchText)
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 6)
                }
            } // Hstack
            .background(Color.rzhdGray)
            .cornerRadius(10)
            .frame(height: 36)
            ZStack {
                VStack {
                    Spacer()
                    ScrollView (showsIndicators: false) {
                        LazyVStack(spacing: 0) {
                            ForEach(viewModel.filtered_cities) { city in
                                CityRowView(city: city)
                                
                                    .onTapGesture {
                                        proceedCityName(city: city)
                                        
                                    }
                            }
                        }
                    } // ScrollView
                    Spacer()
                }
                if viewModel.filtered_cities.isEmpty {
                    VStack {
                        Spacer()
                        Text("Город не найден")
                            .font(.system(size: 24))
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                    } // VSTACK ALERT
                    .background(.white)
                }
            }
        }.padding(.horizontal, 16)
        .navigationTitle("Выбор города").navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    searchData.currentlySelectedTextField = .nothing
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
