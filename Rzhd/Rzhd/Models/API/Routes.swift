//
//  Routes.swift
//  Rzhd
//
//  Created by Александр Поляков on 06.03.2024.
//

// 1. Импортируем библиотеки
import OpenAPIRuntime
import OpenAPIURLSession

typealias Routes = Components.Schemas.Routes

protocol RoutesSearchProtocol {
    func search(from: String, to: String, date: String, transfers: Bool) async throws -> Routes
}

final class RoutesSearchService: RoutesSearchProtocol, @unchecked Sendable {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func search(from: String, to: String, date: String, transfers: Bool = false) async throws -> Routes {
        
        let response = try await client.search(query: .init(
            apikey: apikey,
            from: from,
            to: to,
            date: date,
            transfers: transfers
        ))
        print (response)
        return try response.ok.body.json
    }
}
