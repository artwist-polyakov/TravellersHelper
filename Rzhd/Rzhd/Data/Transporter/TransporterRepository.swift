//
//  TransporterRepository.swift
//  Rzhd
//
//  Created by Александр Поляков on 17.07.2024.
//

import Foundation

actor TransporterRepository {
    static let shared = TransporterRepository()
    private var selectedTransporterCode: Int? = nil
    
    func setSelectedTransporterCode(_ code: Int?) async {
        selectedTransporterCode = code
    }
}
