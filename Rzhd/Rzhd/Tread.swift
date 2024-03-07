//
//  Tread.swift
//  Rzhd
//
//  Created by Александр Поляков on 07.03.2024.
//

// 1. Импортируем библиотеки
import OpenAPIRuntime
import OpenAPIURLSession

typealias Thread = Components.Schemas.Thread

protocol ThreadSearchProtocol {
    func search(uid: String) async throws -> Thread
}

final class ThreadSearchService: ThreadSearchProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func search(uid: String) async throws -> Thread {
        
        let response = try await client.thread(query: .init(
            apikey: apikey,
            uid: string
        ))
        return try response.ok.body.json
    }
}

