//
//  SearchInteractor.swift
//  Rzhd
//
//  Created by Александр Поляков on 16.07.2024.
//

import Foundation

class SearchInteractor {
    
    private let repository = SearchRepository.shared
    private let filterRepository = FilterRepository.shared
    private let transporterRepository = TransporterRepository.shared
    
    init() {
        Task {
            await setDate() // по умолчанию смотрим рейсы на завтра
        }
    }
    
    func search(from: String, to: String) async -> [SearchResult] {
        do {
            await filterRepository.configureRepository(repository)
            let routes = try await repository.search(from: from, to: to)
            let filteredRoutes = filterRepository.filterRoutes(routes)
            
            
            return (filteredRoutes.segments ?? []).compactMap {
                let uri: URL?
//                do {
//                    print ($0.value1.thread?.carrier?.code ?? "!")
//                } catch {
//                    print("Error: \(error)")
//                }
                                
                if let logo = $0.value1.thread?.carrier?.logo {
                    uri = URL(string: logo)
                } else {
                    uri = nil
                }
                
                let departureTime = Date.fromISO8601String($0.value2.departure)
                let arrivalTime = Date.fromISO8601String($0.value2.arrival)

                if departureTime == nil {
                    print("Failed to parse departure time: \($0.value2.departure ?? "nil")")
                }
                if arrivalTime == nil {
                    print("Failed to parse arrival time: \($0.value2.arrival ?? "nil")")
                }
                
                return SearchResult(
                    transporter: Transporter(
                        name: $0.value1.thread?.carrier?.title ?? "???",
                        logoUrl: uri,
                        code: $0.value1.thread?.carrier?.code ?? nil
                    ),
                    departureTime: departureTime ?? Date(),
                    arrivalTime: arrivalTime ?? Date(),
                    transferComment: $0.value1.has_transfers ?? false ? "Есть пересадки" : "Без пересадок"
                )
            }
        }
        
        catch {
            print("Error: \(error)")
            return []
        }
    }
    
    func setDate(_ date: String? = nil) async {
        await repository.setDate(date)
    }
    
    func setTransporterCode(_ transporter: Transporter) async {
        await transporterRepository.setSelectedTransporterCode(transporter.code ?? nil)
    }
}
