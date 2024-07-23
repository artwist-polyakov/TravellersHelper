//
//  ScheduleViewModel.swift
//  Rzhd
//
//  Created by Александр Поляков on 14.07.2024.
//

import Foundation

@MainActor
final class ScheduleViewModel: ObservableObject, @unchecked Sendable {
    private let stationInteractor = StationsInteractor()
    
    func isDataLoaded() async -> Bool {
        return await stationInteractor.isDataLoaded()
    }
}
