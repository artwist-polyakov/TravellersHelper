//
//  СitiesView.swift
//  Rzhd
//
//  Created by Александр Поляков on 15.04.2024.
//

import SwiftUI

struct CitiesView: View {
    @EnvironmentObject var searchData: SearchData
    @ObservedObject var router = PathRouter.shared
    @State private var searchText: String = ""
    @StateObject var viewModel = CitiesViewModel()
    
    func proceedCityName(city: City) {
        if (router.isEmpty()) {
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
        self.router.pushPath(.stationsList)
    }
    
    var body: some View {
        
        VStack {
            if viewModel.isLoading {
                            ProgressView("Загрузка городов...")
            } else {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(searchText.isEmpty ? .gray : .black)
                        .padding(.leading, 8)
                    TextField("Введите запрос", text: $searchText) .onChange(of: searchText) { _, newValue in
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
                        .background(Color.colorPrimary.edgesIgnoringSafeArea(.all))
                    }
                }
            }
        }.padding(.horizontal, 16)
            .background(Color.colorPrimary.edgesIgnoringSafeArea(.all))
        .navigationTitle("Выбор города").navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    searchData.currentlySelectedTextField = .nothing
                    self.router.popPath()
                }) {
                    Image( "NavBackButton")
                        .foregroundColor(Color.rzhdGreyBackButton)
                }
            }
        } .task {
            await viewModel.loadCities()
        }
    }
}




#Preview {
    CitiesView()
}
