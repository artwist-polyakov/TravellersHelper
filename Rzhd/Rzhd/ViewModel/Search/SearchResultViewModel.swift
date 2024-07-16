//
//  SearchResultViewModel.swift
//  Rzhd
//
//  Created by Александр Поляков on 22.04.2024.
//

import Foundation

@MainActor
final class SearchResultViewModel: ObservableObject {
    
    @Published var searchResult: [SearchResult] = []
    private let interactor = SearchInteractor()
    @Published var isLoading = false
    
    private func getSearchResult() -> [SearchResult] {
        var result: [SearchResult] = []
        result.reserveCapacity(1000)
        for _ in 0...999 {
            result.append(SearchResult.generateRandom())
        }
        return result
    }
    
    func loadResults(from: String, to: String) async {
        isLoading = true
        let results = await interactor.search(from: from, to: to)
        self.searchResult = results
        isLoading = false
    }
    
    
}
