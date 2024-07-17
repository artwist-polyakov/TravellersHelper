//
//  TransporterRepository.swift
//  Rzhd
//
//  Created by Александр Поляков on 17.07.2024.
//

import Foundation
import OpenAPIURLSession

actor TransporterRepository {
    static let shared = TransporterRepository()
    private let client: Client
    private var selectedTransporterCode: Int? = nil
    
    private init() {
        self.client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
    }
    
    func setSelectedTransporterCode(_ code: Int?) async {
        selectedTransporterCode = code
    }
    
    func getTransporter() async -> Carrier?{
        let service = CarrierSearchService(
            client: client,
            apikey: API_KEY
        )
        guard let code = selectedTransporterCode else {
            return nil
        }
        do {
            return try await service.search(code: String(code))
        } catch {
            return nil
        }
    }
}
