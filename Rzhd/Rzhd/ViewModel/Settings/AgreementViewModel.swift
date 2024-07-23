//
//  AgreementViewModel.swift
//  Rzhd
//
//  Created by Александр Поляков on 25.06.2024.
//

import Foundation

@MainActor
final class AgreementViewModel: ObservableObject {
    private let usecase: AgreementLinkUsecase = AgreementLinkUsecase()
    
    func getAgreementLink() -> String {
        return usecase.getAgreementLink()
    }
    
    static func create() -> AgreementViewModel {
            return AgreementViewModel()
        }
    
}
