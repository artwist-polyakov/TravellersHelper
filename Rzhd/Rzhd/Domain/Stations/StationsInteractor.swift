//
//  StationsInteractor.swift
//  Rzhd
//
//  Created by Александр Поляков on 14.07.2024.
//

import Foundation

final class StationsInteractor {
    private let dataSource = RussianStationsDataSource.shared
    
    func isDataLoaded() async -> Bool {
        return await !dataSource.isLoading()
    }
    
    func getCities() async -> [City] {
        let data = try! await dataSource.getCities()
        return data.map { City(name: $0.title) }
    }
}
