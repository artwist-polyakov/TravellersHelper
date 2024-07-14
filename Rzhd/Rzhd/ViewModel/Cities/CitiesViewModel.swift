//
//  CitiesViewModel.swift
//  Rzhd
//
//  Created by Александр Поляков on 17.04.2024.
//

import Foundation

@MainActor
final class CitiesViewModel: ObservableObject {
    private var cities: [City] = []
    private let interactor = StationsInteractor()
    @Published var filtered_cities: [City] = []
    @Published var isLoading = false
    
    
    func loadCities() async {
            isLoading = true
            let data = await interactor.getCities()
            self.cities = data
            self.filtered_cities = data
            isLoading = false
        }
    
    func onTextChanged(_ text: String) {
            if text.isEmpty {
                self.filtered_cities = cities
            } else {
                let lowercasedText = text.lowercased()
                self.filtered_cities = cities.filter { city in
                    let lowercasedName = city.name.lowercased()
                    return lowercasedName.starts(with: lowercasedText) ||
                           lowercasedName.contains(" \(lowercasedText)")
                }
            }
        }
    
    private func getCities() -> [City] {
        return [
            City(name: "Москва"),
            City(name: "Санкт-Петербург"),
            City(name: "Новосибирск"),
            City(name: "Екатеринбург"),
            City(name: "Нижний Новгород"),
            City(name: "Казань"),
            City(name: "Челябинск"),
            City(name: "Омск"),
            City(name: "Самара"),
            City(name: "Ростов-на-Дону"),
            City(name: "Уфа"),
            City(name: "Красноярск"),
            City(name: "Пермь"),
            City(name: "Воронеж"),
            City(name: "Волгоград"),
            City(name: "Краснодар"),
            City(name: "Саратов"),
            City(name: "Тюмень"),
            City(name: "Тольятти"),
            City(name: "Ижевск"),
            City(name: "Барнаул"),
            City(name: "Ульяновск"),
            City(name: "Иркутск"),
            City(name: "Хабаровск"),
            City(name: "Ярославль"),
            City(name: "Владивосток"),
            City(name: "Махачкала"),
            City(name: "Томск"),
            City(name: "Оренбург"),
            City(name: "Кемерово"),
            City(name: "Новокузнецк"),
            City(name: "Рязань"),
            City(name: "Астрахань"),
            City(name: "Пенза"),
            City(name: "Липецк"),
            City(name: "Киров"),
            City(name: "Чебоксары"),
            City(name: "Балашиха"),
            City(name: "Калининград"),
            City(name: "Тула"),
            City(name: "Севастополь"),
            City(name: "Сочи"),
            City(name: "Ставрополь"),
            City(name: "Улан-Удэ")
            ]
    }
}
