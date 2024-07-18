//
//  FilterRepository.swift
//  Rzhd
//
//  Created by Александр Поляков on 16.07.2024.
//

import Foundation

final class FilterRepository {
    static let shared = FilterRepository()
    
    private var constraints = SearchConstraits()
    
    func setConstraints(_ constraints: SearchConstraits) {
        self.constraints = constraints
    }
    
    func configureRepository(_ searchRepository: SearchRepository) async {
        await searchRepository.setWithTransfers(constraints.includingWithTransfer)
    }
    
    func filterRoutes(_ routes: Routes) -> Routes {
        var routesCopy = routes
        routesCopy.segments = routes.segments?.filter { segment in
            guard let departureTime = Date.fromISO8601String(segment.value2.departure) else {
                print("Failed to parse departure time: \(segment.value2.departure ?? "nil")")
                return false
            }
            let hour = Calendar.current.component(.hour, from: departureTime)
            switch hour {
            case 0...5:
                return constraints.includingNight
            case 6...11:
                return constraints.includingMorning
            case 12...17:
                return constraints.includingDay
            case 18...23:
                return constraints.includingEvening
            default:
                return false
            }
        }
        return routesCopy
    }
}
