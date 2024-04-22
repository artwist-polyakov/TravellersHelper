//
//  TransporterViewModel.swift
//  Rzhd
//
//  Created by Александр Поляков on 22.04.2024.
//

import Foundation

class TransporterViewModel: ObservableObject {
    
    @Published var transporter = DetailedTransporter(
        name: "ОАО РЖД", bigLogoUri: "BigRZHDLogo", email: "test@test.test", phone: "+7 (999) 123-12-23")
    
}

