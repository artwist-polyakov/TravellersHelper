//
//  StationsMode;ls.swift
//  Rzhd
//
//  Created by Александр Поляков on 14.07.2024.
//

import Foundation

struct StationCode: Codable {
    let esrCode: String?
    let yandexCode: String?
    
    enum CodingKeys: String, CodingKey {
        case esrCode = "esr_code"
        case yandexCode = "yandex_code"
    }
}

struct StationModel: Codable, Identifiable, Comparable {
    let id: String
    let title: String
    let longitude: Double
    let latitude: Double
    let transportType: String
    let stationType: String
    
    static func < (lhs: StationModel, rhs: StationModel) -> Bool {
        lhs.id < rhs.id
    }
}

struct CityModel: Codable, Identifiable, Comparable {
    let id: String
    let title: String
    let stations: [StationModel]
    
    static func < (lhs: CityModel, rhs: CityModel) -> Bool {
        lhs.id < rhs.id
    }
}

struct RussianCitiesAndStations {
    let cities: [CityModel]
    
    init(cities: [CityModel]) {
        self.cities = cities.sorted( by: { $0.title < $1.title })
    }
    
    func findCity(byId id: String) -> CityModel? {
        cities.first { $0.id == id }
    }
    
    func findStation(inCity city: CityModel, byId id: String) -> StationModel? {
        city.stations.first { $0.id == id }
    }
}

