//
//  Copyright.swift
//  Rzhd
//
//  Created by Александр Поляков on 07.03.2024.
//

// 1. Импортируем библиотеки
import OpenAPIRuntime
import OpenAPIURLSession

typealias Copyright = Components.Schemas.CopyrightAnswer

protocol CopyrightProtocol {
    func get() async throws -> Copyright
}

final class CopyrightService: CopyrightProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func get() async throws -> Copyright {
        
        let response = try await client.getCopyright(query: .init(
            apikey: apikey
        ))
        return try response.ok.body.json
    }
}

