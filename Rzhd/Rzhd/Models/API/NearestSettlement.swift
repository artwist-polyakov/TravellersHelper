//
//  NearestSettlement.swift
//  Rzhd
//
//  Created by Александр Поляков on 07.03.2024.
//

// 1. Импортируем библиотеки
import OpenAPIRuntime
import OpenAPIURLSession

// 2. Улучшаем читаемость кода — необязательный шаг
typealias NearestSettlement = Components.Schemas.Settlement

protocol NearestSettlementProtocol {
    func getNearestSSettlement(lat: Double, lng: Double) async throws -> NearestSettlement
}

final class NearestSettlementService: NearestSettlementProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getNearestSSettlement(lat: Double, lng: Double) async throws -> NearestSettlement {
        // В документе с описанием запроса мы задали параметры apikey, lat, lng и distance
        // Для вызова сгенерированной функции нужно передать эти параметры
        let response = try await client.getNearestSettlement(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng
        ))
        return try response.ok.body.json
    }
}
