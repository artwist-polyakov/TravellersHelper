//
//  CitiesViewModel.swift
//  Rzhd
//
//  Created by Александр Поляков on 17.04.2024.
//

import Foundation

final class CitiesViewModel: ObservableObject {
    private var cities: [City] = []
    @Published var filtered_cities: [City] = []
    
    init() {
        self.cities = getCities()
        self.filtered_cities = cities
    }
    
    func onTextChanged(_ text: String) {
        if text.isEmpty {
            self.filtered_cities = cities
        } else {
            self.filtered_cities = cities.filter { $0.name.lowercased().contains(text.lowercased()) }
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
