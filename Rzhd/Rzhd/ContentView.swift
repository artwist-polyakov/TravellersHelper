//
//  ContentView.swift
//  Rzhd
//
//  Created by Александр Поляков on 01.03.2024.
//

import SwiftUI
import OpenAPIURLSession
import HTTPTypes
import Foundation

// MARK: - ContentView
struct ContentView: View {
    @StateObject var searchData = SearchData()
    @ObservedObject var themeViewModel = DarkThemeViewModel.shared
    @State private var selectedTab = 0
    @ObservedObject var router: PathRouter = PathRouter.shared
    @State private var path: [NavigationIdentifiers] = []
    @State private var stories = StoriesPack.stories
    @State private var storiesMemo = StoriesMemoization() // тут просится вьюмодель
    let stationsSource = RussianStationsDataSource.shared
    
    var body: some View {
        NavigationStack(path: $router.path) {
            TabView(selection: $selectedTab) {
                
                ScheduleView(stories: $stories,memo: $storiesMemo).environmentObject(searchData)
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
                SettingsView()
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
                        CitiesView().environmentObject(searchData)
                    case .stationsList:
                        StationsView().environmentObject(searchData)
                    case .searchResultsList:
                        SearchResultView().environmentObject(searchData)
                    case .filterList:
                        FilterView().environmentObject(searchData)
                    case .detailedTransporter:
                        TransporterView().environmentObject(searchData)
                    case .agreement:
                        AgreementView()
                    case .stories:
                        StoriesView(
                            stories: $stories,
                            memo: $storiesMemo)
                    }
                }
        }.preferredColorScheme(themeViewModel.themeConfig.isDarkMode ? .dark : .light)
            .background(Color.colorPrimary.edgesIgnoringSafeArea(.all))
            .onAppear {
                Task {
                    _ = await RussianStationsDataSource.shared.isLoading()
                }
                //                    UITabBar.appearance().barTintColor = .white
                //            copyright()
                //            search()
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
    
    func convertDataToJSON(_ data: Data) throws -> Any {
        let options: JSONSerialization.ReadingOptions = [.allowFragments, .mutableContainers, .mutableLeaves]
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: options)
        
        if let dict = jsonObject as? [String: Any] {
            return cleanUpUnicode(dict)
        } else if let array = jsonObject as? [Any] {
            return array.map { ($0 as? [String: Any]).map(cleanUpUnicode) ?? $0 }
        }
        
        return jsonObject
    }
    
    func cleanUpUnicode(_ dict: [String: Any]) -> [String: Any] {
        var cleanDict = [String: Any]()
        for (key, value) in dict {
            if let stringValue = value as? String {
                cleanDict[key] = stringValue.removingPercentEncoding ?? stringValue
            } else if let nestedDict = value as? [String: Any] {
                cleanDict[key] = cleanUpUnicode(nestedDict)
            } else if let nestedArray = value as? [Any] {
                cleanDict[key] = nestedArray.map { ($0 as? [String: Any]).map(cleanUpUnicode) ?? $0 }
            } else {
                cleanDict[key] = value
            }
        }
        return cleanDict
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
