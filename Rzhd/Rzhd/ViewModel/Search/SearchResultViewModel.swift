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
    
    func loadResults(from: String, to: String) async {
        isLoading = true
        let results = await interactor.search(from: from, to: to)
        self.searchResult = results
        isLoading = false
    }
    
    func setTransporter(transporter: Transporter) {
        Task {
            await interactor.setTransporterCode(transporter)
        }
    }
    
    
}
