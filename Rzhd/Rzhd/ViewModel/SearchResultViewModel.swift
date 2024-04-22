//
//  SearchResultViewModel.swift
//  Rzhd
//
//  Created by Александр Поляков on 22.04.2024.
//

import Foundation

final class SearchResultViewModel: ObservableObject {
    
    @Published var searchResult: [SearchResult] = []
    
    init() {
        self.searchResult = getSearchResult()
    }
    
    private func getSearchResult() -> [SearchResult] {
        var result: [SearchResult] = []
        result.reserveCapacity(1000)
        for i in 0...999 {
            result.append(SearchResult.generateRandom())
        }
        return result
    }
    
    
}
