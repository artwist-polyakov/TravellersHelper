//
//  RussianStationsDataSource.swift
//  Rzhd
//
//  Created by Александр Поляков on 14.07.2024.
//

import Foundation
import OpenAPIURLSession

actor RussianStationsDataSource {
    static let shared = RussianStationsDataSource()
    private var russianStations: RussianCitiesAndStations?
    private let client: Client
    private var loadingTask: Task<Void, Error>?
    private var isLoaded = false
    
    private init() {
        self.client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        self.loadingTask = Task { try await self.loadStations() }
    }

    private func filterRussianCitiesAndStations(_ data: [String: Any]) -> [[String: Any]] {
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
    
    private func parseRussianCitiesAndStations(_ data: [String: Any]) -> RussianCitiesAndStations {
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
    
    func isLoading() -> Bool {
        return !isLoaded
    }
    
    func awaitLoading() async throws {
        if let task = loadingTask {
            try await task.value
        } else if !isLoaded {
            try await loadStations()
        }
    }
    
    func getCities() async throws -> [CityModel] {
        try await awaitLoading()
        return russianStations?.cities ?? []
    }
    
    func findCity(byId id: String) async throws -> CityModel? {
        try await awaitLoading()
        return russianStations?.findCity(byId: id)
    }
    
    func findStation(inCity city: CityModel, byId id: String) async throws -> StationModel? {
        try await awaitLoading()
        return russianStations?.findStation(inCity: city, byId: id)
    }

    private func loadStations() async throws {
        guard !isLoaded else { return }
        
        do {
            let service = AllStationsService(client: client, apikey: API_KEY)
            let stations = try await service.get()
            let data = try await Data(collecting: stations, upTo: 100*1024*1024)
            
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            self.russianStations = parseRussianCitiesAndStations(jsonResult)
            
            isLoaded = true
            print("Total cities: \(self.russianStations?.cities.count ?? 0)")
        } catch {
            isLoaded = false
            throw error
        }
    }
}
