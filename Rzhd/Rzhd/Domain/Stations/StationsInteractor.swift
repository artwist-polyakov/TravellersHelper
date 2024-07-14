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
}
