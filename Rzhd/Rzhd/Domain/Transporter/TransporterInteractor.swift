//
//  TransporterInteractor.swift
//  Rzhd
//
//  Created by Александр Поляков on 17.07.2024.
//

import Foundation

final class TransporterInteractor: @unchecked Sendable {
    private let transporterRepository = TransporterRepository.shared
    
    func getTransporter() async -> DetailedTransporter {
        var result = DetailedTransporter()
        let transporter = await transporterRepository.getTransporter()
        if let transporterName = transporter?.carrier?.title {
            result.name = transporterName
        }
        if let transporterLogo = transporter?.carrier?.logo {
            result.bigLogoUri = URL(string: transporterLogo)
        }
        if let trasporterPhone = transporter?.carrier?.phone {
            result.phone = trasporterPhone
        } else {
            result.phone = "Поле phone не заполнено"
        }
        if let transporterEmail = transporter?.carrier?.email {
            result.email = transporterEmail
        } else {
            result.email = "Поле email не заполнено"
        }
        return result
    }
}
