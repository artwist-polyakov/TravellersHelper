//
//  SearchRepository.swift
//  Rzhd
//
//  Created by Александр Поляков on 15.07.2024.
//

import Foundation
import OpenAPIURLSession

actor SearchRepository {
    static let shared = SearchRepository()
    private let client: Client
    private var settledDate: String? = nil // дата в формате yyyy-MM-dd
    
    private init() {
        self.client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
    }
    
    func setDate(_ date: String? = nil) {
        if let date = date {
            self.settledDate = date
        } else {
            let tomorrowDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            self.settledDate = formatter.string(from: tomorrowDate)
            print("Settled date: \(self.settledDate ?? "nil")")
        }
    }
    
    func search(from: String, to: String) async throws -> Routes {
        let service = RoutesSearchService (
            client: client,
            apikey: API_KEY
        )
        
        return try await service.search(from: from, to: to, date: settledDate ?? "", transfers: true)
    }

    
}
