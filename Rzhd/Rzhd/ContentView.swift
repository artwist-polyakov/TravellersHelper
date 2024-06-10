//
//  ContentView.swift
//  Rzhd
//
//  Created by Александр Поляков on 01.03.2024.
//

import SwiftUI
import OpenAPIURLSession
import HTTPTypes


enum NavigationIdentifiers: String {
    case citiesList = "CitiesList"
    case stationsList = "StationsList"
    case searchResultsList = "SearchResultsList"
    case filterList = "FilterList"
    case detailedTransporter = "DetailedTransporter"
    case agreement = "Agreement"
    case stories = "Stories"
}

// MARK: - ContentView
struct ContentView: View {
    @StateObject var searchData = SearchData()
    @StateObject var themeConfig = ThemeConfig()
    
    @State private var selectedTab = 0
    @State private var path: [NavigationIdentifiers] = []
    @State private var stories = StoriesPack.stories
    @State private var storiesMemo = StoriesMemoization() // тут просится вьюмодель
    
    var body: some View {
        NavigationStack(path: $path) {
            TabView(selection: $selectedTab) {
                ScheduleView(path: $path, stories: $stories,
                             memo: $storiesMemo
                ).environmentObject(searchData)
                    .tabItem {
                        Image("ScheduleIcon")
                            .renderingMode(.template)
                    }.overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray).padding(.bottom, 12),
                        alignment: .bottom
                    )
                    .tag(0)
                    .edgesIgnoringSafeArea(.top)
                    .toolbarBackground(Color("TabBarColor"), for: .tabBar)
                SettingsView(path: $path).environmentObject(themeConfig)
                    .tabItem {
                        Image("SettingsIcon")
                            .renderingMode(.template)
                    }  .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray).padding(.bottom, 12),
                        alignment: .bottom
                        
                    )
                    .tag(0)
                    .edgesIgnoringSafeArea(.top)
                    .toolbarBackground(Color("TabBarColor"), for: .tabBar)
            }.accentColor(.colorOnPrimary)
                .environmentObject(searchData)
                .navigationDestination(for: NavigationIdentifiers.self) { id in
                    switch (id) {
                    case .citiesList:
                        CitiesView(path: $path).environmentObject(searchData)
                    case .stationsList:
                        StationsView(path: $path).environmentObject(searchData)
                    case .searchResultsList:
                        SearchResultView(path: $path).environmentObject(searchData)
                    case .filterList:
                        FilterView(path: $path).environmentObject(searchData)
                    case .detailedTransporter:
                        TransporterView(path: $path).environmentObject(searchData)
                    case .agreement:
                        AgreementView(path:$path)
                    case .stories:
                        StoriesView(
                            stories: $stories,
                            memo: $storiesMemo, path: $path)
                    }
                }
        }.preferredColorScheme(themeConfig.isDarkMode ? .dark : .light)
            .background(Color.colorPrimary.edgesIgnoringSafeArea(.all))
            .onAppear {
                //                    UITabBar.appearance().barTintColor = .white
                //            copyright()
                //            search()
                //            allStations ()
                //            stations()
                //            thread()
                //            settlement()
                //            carrier()
            }
    }
    // MARK: - Search
    func search() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = RoutesSearchService (
            client: client,
            apikey: API_KEY
        )
        
        Task {
            do {
                let result = try await service.search(from: "c239", to: "c213",  date: "2024-03-09")
                print(result)
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    // MARK: - AllStations
    func allStations() {
        
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = AllStationsService(
            client: client,
            apikey: API_KEY
        )
        Task {
            do {
                let stations = try await service.get()
                let data = try await Data(collecting: stations, upTo: 100*1024*1024)
                print("data size: \(data.count)")
                let allStations = try JSONDecoder().decode(Components.Schemas.AllStations.self, from: data)
                print("All stations: \(allStations)")
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    // MARK: - Carrier
    func carrier() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = CarrierSearchService(
            client: client,
            apikey: API_KEY
        )
        Task {
            do {
                let thread = try await service.search(code: "MS", system: .iata)
                print(thread)
            } catch {
                print("Error fetching thread: \(error)")
            }
        }
    }
    
    func thread() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        let service = ThreadSearchService(
            client: client,
            apikey: API_KEY
        )
        Task {
            do {
                let thread = try await service.search(uid: "176YE_7_2")
                print(thread)
            } catch {
                print("Error fetching thread: \(error)")
            }
        }
    }
    
    func stations() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        let service = NearestStationsService(
            client: client,
            apikey: API_KEY
        )
        Task {
            do {
                let stations = try await service.getNearestStations(lat:
                                                                        59.864177, lng: 30.319163, distance: 50)
                print(stations)
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }

    func settlement() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = NearestSettlementService(
            client: client,
            apikey: API_KEY
        )
        Task {
            do {
                let result = try await service.getNearestSSettlement(lat:59.864177, lng: 30.319163)
                print(result)
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    func copyright() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        let service = CopyrightService(
            client: client,
            apikey: API_KEY
        )
        Task {
            do {
                let result = try await service.get()
                print(result)
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
