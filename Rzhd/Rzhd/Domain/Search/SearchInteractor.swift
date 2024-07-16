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
    
    init() {
        Task {
            await setDate() // по умолчанию смотрим рейсы на завтра
        }
    }
    
    func search(from: String, to: String) async throws -> Routes {
        return try await repository.search(from: from, to: to)
    }
    
    func setDate(_ date: String? = nil) async {
        await repository.setDate(date)
    }
}
