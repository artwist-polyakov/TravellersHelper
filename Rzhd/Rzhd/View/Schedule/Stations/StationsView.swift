//
//  StationsView.swift
//  Rzhd
//
//  Created by Александр Поляков on 21.04.2024.
//

import SwiftUI

import SwiftUI

struct StationsView: View {
    @EnvironmentObject var searchData: SearchData
    var router: PathRouter = PathRouter.shared
    @State private var searchText: String = ""
    @StateObject var viewModel = StationsViewModel()
    
    func proceedStation(station: Station) {
        if (router.isEmpty()) {
            return
        }
        switch searchData.currentlySelectedTextField {
        case .from:
            searchData.stationFrom = station
        case .to:
            searchData.stationTo = station
        case .nothing:
            break
        }
        searchData.currentlySelectedTextField = .nothing
        searchData.configureTextValues()
        self.router.removeAll()
    }
    
    var body: some View {
        
        VStack {
            if viewModel.isLoading {
                ProgressView("Загрузка станций...")
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
                                ForEach(viewModel.filtered_stations) { station in
                                    StationRowView(station: station)
                                    
                                        .onTapGesture {
                                            proceedStation(station: station)
                                            
                                        }
                                }
                            }
                        } // ScrollView
                        Spacer()
                    }
                    if viewModel.filtered_stations.isEmpty {
                        VStack {
                            Spacer()
                            Text("Станция не найдена")
                                .font(.system(size: 24))
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .center)
                            Spacer()
                        } // VSTACK ALERT
                        .background(Color.colorPrimary.edgesIgnoringSafeArea(.all))
                    }
                }
            }}.padding(.horizontal, 16)
            .background(Color.colorPrimary.edgesIgnoringSafeArea(.all))
            .navigationTitle("Выбор станции").navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.router.popPath()
                    }) {
                        Image( "NavBackButton")
                            .foregroundColor(Color.rzhdGreyBackButton)
                    }
                }
            }.task {
                let currentCity = searchData.currentlySelectedTextField == .from ? searchData.cityFrom : searchData.cityTo
                guard currentCity != nil else {
                    return
                }
                await viewModel.loadStations(city: currentCity! )
            }
    }
}




#Preview {
    StationsView()
}
