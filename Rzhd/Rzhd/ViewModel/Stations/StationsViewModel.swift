//
//  StationsViewModel.swift
//  Rzhd
//
//  Created by Александр Поляков on 21.04.2024.
//

import Foundation

@MainActor
final class StationsViewModel: ObservableObject {
    private var stations: [Station] = []
    private let interactor = StationsInteractor()
    @Published var filtered_stations: [Station] = []
    @Published var isLoading = false
    
    func onTextChanged(_ text: String) {
        if text.isEmpty {
            self.filtered_stations = stations
        } else {
            let lowercasedText = text.lowercased()
            self.filtered_stations = stations.filter { station in
                let lowercasedName = station.name.lowercased()
                return lowercasedName.starts(with: lowercasedText) ||
                       lowercasedName.contains(" \(lowercasedText)")}
        }
    }
    
    func loadStations(city: City) async {
        isLoading = true
        let stations = await interactor.getStations(city: city)
        self.stations = stations
        self.filtered_stations = stations
        isLoading = false
        
    }
    
    private func getStations() -> [Station] {
        return [
            Station(name: "Абросимово"),
            Station(name: "Антропово"),
            Station(name: "Арменки"),
            Station(name: "Архангельск"),
            Station(name: "Архангельск (перев.)"),
            Station(name: "Архангельск (эксп.)"),
            Station(name: "Архангельск-Город"),
            Station(name: "Архангельск-Город (перев.)"),
            Station(name: "Архангельск-Город (эксп.)"),
            Station(name: "Бавлены"),
            Station(name: "Бакарица"),
            Station(name: "Бакарица (перев.)"),
            Station(name: "Бакарица (эксп.)"),
            Station(name: "Бакланка"),
            Station(name: "Балакирево"),
            Station(name: "Беклемишево"),
            Station(name: "Березовый"),
            Station(name: "Берендеево"),
            Station(name: "Большаково"),
            Station(name: "Большая Кяма"),
            Station(name: "Брантовка"),
            Station(name: "Брусеница"),
            Station(name: "Буй"),
            Station(name: "Бурачиха"),
            Station(name: "Бурмакино"),
            Station(name: "Бушуиха"),
            Station(name: "Вага"),
            Station(name: "Валдеево"),
            Station(name: "Вандыш"),
            Station(name: "Варакинский"),
            Station(name: "Варегово"),
            Station(name: "Васьково"),
            Station(name: "Ваулово"),
            Station(name: "Вежайка"),
            Station(name: "Вездино"),
            Station(name: "Великий Устюг"),
            Station(name: "Вельск"),
            Station(name: "Вендинга"),
            Station(name: "Вересово"),
            Station(name: "Верх")
        ]
    }
}
