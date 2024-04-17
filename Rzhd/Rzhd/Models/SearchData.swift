//
//  SearchData.swift
//  Rzhd
//
//  Created by Александр Поляков on 17.04.2024.
//

import Foundation

enum CurrentlySelectedTextField {
    case from
    case to
    case nothing
}

class SearchData: ObservableObject {
     @Published var fromText: String = ""
     @Published var toText: String = ""
     @Published var currentlySelectedTextField: CurrentlySelectedTextField = .nothing
 }
