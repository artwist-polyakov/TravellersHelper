//
//  AgreementLinkUsecase.swift
//  Rzhd
//
//  Created by Александр Поляков on 25.06.2024.
//

import Foundation

final class AgreementLinkUsecase {
    
    private let repository: AgreementLinkRepository = AgreementLinkRepository()
    
    func getAgreementLink() -> String {
        return repository.getAgreementLink()
    }
}
