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
                //                    UITabBar.appearance().barTintColor = .white
                //            copyright()
                //            search()
                            allStations ()
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
    
    func filterRussianCitiesAndStations(_ data: [String: Any]) -> [[String: Any]] {
        guard let countries = data["countries"] as? [[String: Any]] else {
            return []
        }
        
        let russianCities = countries.first { ($0["title"] as? String) == "Россия" }?["regions"] as? [[String: Any]] ?? []
        
        return russianCities.compactMap { region -> [String: Any]? in
            guard let regionTitle = region["title"] as? String,
                  let settlements = region["settlements"] as? [[String: Any]] else {
                return nil
            }
            
            let cityStations = settlements.compactMap { settlement -> [String: Any]? in
                guard let cityTitle = settlement["title"] as? String,
                      let stations = settlement["stations"] as? [[String: Any]] else {
                    return nil
                }
                
                return [
                    "city": cityTitle,
                    "stations": stations.map { [
                        "title": $0["title"] as? String ?? "",
                        "station_type": $0["station_type"] as? String ?? "",
                        "transport_type": $0["transport_type"] as? String ?? ""
                    ]}
                ]
            }
            
            return ["region": regionTitle, "cities": cityStations]
        }
    }
    
    func parseRussianCitiesAndStations(_ data: [String: Any]) -> RussianCitiesAndStations {
        guard let countries = data["countries"] as? [[String: Any]] else {
            return RussianCitiesAndStations(cities: [])
        }
        
        let russianCities = countries.flatMap { country -> [CityModel] in
            guard let countryTitle = country["title"] as? String,
                  countryTitle == "Россия",
                  let regions = country["regions"] as? [[String: Any]] else {
                return []
            }
            
            return regions.flatMap { region -> [CityModel] in
                guard let settlements = region["settlements"] as? [[String: Any]] else {
                    return []
                }
                
                return settlements.compactMap { settlement -> CityModel? in
                    guard let cityTitle = settlement["title"] as? String,
                          let cityCodes = settlement["codes"] as? [String: String?],
                          let cityYandexCode = cityCodes["yandex_code"] as? String,
                          let stations = settlement["stations"] as? [[String: Any]] else {
                        return nil
                    }
                    
                    let stationModels = stations.compactMap { station -> StationModel? in
                        guard let stationTitle = station["title"] as? String,
                              let stationCodes = station["codes"] as? [String: String?],
                              let stationYandexCode = stationCodes["yandex_code"] as? String,
                              let longitude = station["longitude"] as? Double,
                              let latitude = station["latitude"] as? Double,
                              let transportType = station["transport_type"] as? String,
                              let stationType = station["station_type"] as? String else {
                            return nil
                        }
                        
                        return StationModel(id: stationYandexCode,
                                            title: stationTitle,
                                            longitude: longitude,
                                            latitude: latitude,
                                            transportType: transportType,
                                            stationType: stationType)
                    }
                    
                    return CityModel(id: cityYandexCode, title: cityTitle, stations: stationModels)
                }
            }
        }
        
        return RussianCitiesAndStations(cities: russianCities)
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
                
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let russianCitiesAndStations = parseRussianCitiesAndStations(jsonResult)
                
                print("Total cities: \(russianCitiesAndStations.cities.count)")
                
                // Пример поиска конкретного города и станции
                if let moscow = russianCitiesAndStations.findCity(byId: "c213") {  // Предполагаемый Yandex код для Москвы
                    print("\nFound Moscow: \(moscow.title)")
                    print("Total stations in Moscow: \(moscow.stations.count)")
                    if let station = russianCitiesAndStations.findStation(inCity: moscow, byId: "s2000006") {  // Предполагаемый Yandex код для Киевского вокзала
                        print("Found station: \(station.title) (Type: \(station.stationType), Transport: \(station.transportType))")
                    }
                }
                
                // Выводим несколько примеров для демонстрации
                print("\nSample of Russian Cities and Stations:")
                for city in russianCitiesAndStations.cities.prefix(5) {
                    print("City: \(city.title) (ID: \(city.id))")
                    for station in city.stations.prefix(3) {
                        print("  Station: \(station.title) (ID: \(station.id), Type: \(station.stationType), Transport: \(station.transportType))")
                    }
                }
                
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
