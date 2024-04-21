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
    @Published var cityFrom: City? = nil
    @Published var cityTo: City? = nil
    @Published var stationFrom: Station? = nil
    @Published var stationTo: Station? = nil
    @Published var currentlySelectedTextField: CurrentlySelectedTextField = .nothing
    @Published var fromText: String = ""
    @Published var toText: String = ""
    
    private func configureFromTextValue() {
        var result = ""
        if let city = cityFrom {
            result += city.name
        }
        if let station = stationFrom {
            result += " (\(station.name))"
        }
        return fromText = result
    }
    
    private func configureToTextValue() {
        var result = ""
        if let city = cityTo {
            result += city.name
        }
        if let station = stationTo {
            result += " (\(station.name))"
        }
        return toText = result
    }
    
    func configureTextValues() {
        configureFromTextValue()
        configureToTextValue()
    }
    
    func cleanFromData() {
        self.cityFrom = nil
        self.stationFrom = nil
    }
    
    func cleanToData() {
        self.cityTo = nil
        self.stationTo = nil
    }
}
