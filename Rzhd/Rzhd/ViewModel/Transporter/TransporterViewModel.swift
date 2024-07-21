//
//  TransporterViewModel.swift
//  Rzhd
//
//  Created by Александр Поляков on 22.04.2024.
//

import Foundation

@MainActor
final class TransporterViewModel: ObservableObject, @unchecked Sendable {
    
    @Published var transporter: DetailedTransporter? = nil
    private let interactor = TransporterInteractor()
    @Published var isLoading = false
    
    func loadTransporter() async {
        isLoading = true
        let transporter = await interactor.getTransporter()
        self.transporter = transporter
        isLoading = false
    }
    
    func getLogo() -> URL? {
        return transporter?.bigLogoUri
    }
    
}

