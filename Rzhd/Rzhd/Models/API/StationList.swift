//
//  StationList.swift
//  Rzhd
//
//  Created by Александр Поляков on 07.03.2024.
//

// MARK: - нужна помощь с обработкой
// тут ответ содержит 33 мб данных и десериализация выполняется некорректно (по всей видимости 33 мегабайта слишком много

// 1. Импортируем библиотеки
import OpenAPIRuntime
import OpenAPIURLSession

typealias StationList = Components.Schemas.AllStations

protocol AllStationsInfoProtocol {
    func get(format: Operations.getAllStations.Input.Query.formatPayload) async throws -> HTTPBody
}

final class AllStationsService: AllStationsInfoProtocol, @unchecked Sendable {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func get(format: Operations.getAllStations.Input.Query.formatPayload = .json) async throws -> HTTPBody {
        
        let response = try await client.getAllStations(query: .init(
            apikey: apikey,
            format: format
        ))
        return try response.ok.body.html
    }
}



