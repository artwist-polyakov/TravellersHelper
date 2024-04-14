//
//  ContentView.swift
//  Rzhd
//
//  Created by Александр Поляков on 01.03.2024.
//

import SwiftUI
import OpenAPIURLSession
import HTTPTypes

struct ContentView: View {
    
    @State private var selectedTab = 0
    @State private var path: [String] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            TabView(selection: $selectedTab) {
                ScheduleView(path: $path)
                    .tabItem {
                        Image("ScheduleIcon")
                            .renderingMode(.template)
                    }.border(Color.gray)
                
                    .tag(0)
                    .edgesIgnoringSafeArea(.top)
                    .toolbarBackground(Color("TabBarColor"), for: .tabBar)
                SettingsView()
                    .tabItem {
                        Image("SettingsIcon")
                            .renderingMode(.template)
                    }.border(Color.gray)
                
                    .tag(0)
                    .edgesIgnoringSafeArea(.top)
                    .toolbarBackground(Color("TabBarColor"), for: .tabBar)
            }.accentColor(.black)
                .navigationDestination(for: String.self) { id in
                    if id == "CitiesList" {
                        CitiesView(path: $path)
                    }
                }
            }
        
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

