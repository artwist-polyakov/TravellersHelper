//
//  AgreementViewModel.swift
//  Rzhd
//
//  Created by Александр Поляков on 25.06.2024.
//

import Foundation

final class AgreementViewModel {
    private let usecase: AgreementLinkUsecase = AgreementLinkUsecase()
    
    func getAgreementLink() -> String {
        return usecase.getAgreementLink()
    }
    
}
