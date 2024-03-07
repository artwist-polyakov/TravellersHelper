//
//  Carrier.swift
//  Rzhd
//
//  Created by Александр Поляков on 07.03.2024.
//

// 1. Импортируем библиотеки
import OpenAPIRuntime
import OpenAPIURLSession

typealias Carrier = Components.Schemas.OptionalListOfCarriers

protocol CarrierSearchProtocol {
    func search(code: String, system: Operations.getCarrier.Input.Query.systemPayload) async throws -> Carrier
}

final class CarrierSearchService: CarrierSearchProtocol {
  private let client: Client
  private let apikey: String
  
  init(client: Client, apikey: String) {
    self.client = client
    self.apikey = apikey
  }
  
    func search(code: String, system: Operations.getCarrier.Input.Query.systemPayload = .yandex) async throws -> Carrier {

    let response = try await client.getCarrier(query: .init(
        apikey: apikey,
        code: code,
        system: system
    ))
    return try response.ok.body.json
  }
}


