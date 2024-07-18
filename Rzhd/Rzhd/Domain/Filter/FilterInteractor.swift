//
//  FilterInteractor.swift
//  Rzhd
//
//  Created by Александр Поляков on 18.07.2024.
//

import Foundation

final class FilterInteractor {
    private let repository = FilterRepository.shared
    
    func setConstraints(_ constraints: SearchConstraits) async {
        await repository.setConstraints(constraints)
    }
}
