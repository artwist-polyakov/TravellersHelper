//
//  FilterViewModel.swift
//  Rzhd
//
//  Created by Александр Поляков on 22.04.2024.
//

import Foundation

class FilterViewModel: ObservableObject {
    @Published var settings: [SelectionModel] = generateSelection()
    
    
    func configureConstraints(constraints: SearchConstraits) {
        settings = FilterViewModel.generateConstraints(constraints)
    }
    
    func onTap(model: SelectionModel) {
        switch model.isRadioButton() {
        case true:
            settings.forEach { item in
                if item.isRadioButton() {
                    item.isSelected = false
                }
                if item == model {
                    item.isSelected = true
                }
            }
        case false:
            settings.forEach { item in
                if item == model && !item.isRadioButton() {
                    item.isSelected.toggle()
                }
            }
        }
    }
    
    private static func generateConstraints(_ input: SearchConstraits) -> [SelectionModel] {
        return {
            var result  = [
                SelectionModel(name: .morning, isSelected: input.includingMorning, isRadio: false, section: .time),
                SelectionModel(name: .day, isSelected: input.includingDay , isRadio: false, section: .time),
                SelectionModel(name: .evening, isSelected: input.includingEvening, isRadio: false, section: .time),
                SelectionModel(name: .night, isSelected: input.includingNight, isRadio: false, section: .time),
                
                SelectionModel(name: .yes, isSelected: input.includingWithTransfer, isRadio: true, section: .withTransfer),
                SelectionModel(name: .no, isSelected: !input.includingWithTransfer, isRadio: true, section: .withTransfer),
            ]
            if !(!input.includingDay || !input.includingEvening || !input.includingMorning || !input.includingNight) {
                result.forEach { item in
                    if item.section == .time {
                        item.isSelected = false
                    }
                }
            }
            return result
        }()
        
    }
    
    
    private static func generateSelection() -> [SelectionModel] {
        return [
            
            SelectionModel(name: .morning, isSelected: false, isRadio: false, section: .time),
            SelectionModel(name: .day, isSelected: false, isRadio: false, section: .time),
            SelectionModel(name: .evening, isSelected: false, isRadio: false, section: .time),
            SelectionModel(name: .night, isSelected: false, isRadio: false, section: .time),
            
            SelectionModel(name: .yes, isSelected: false, isRadio: true, section: .withTransfer),
            SelectionModel(name: .no, isSelected: false, isRadio: true, section: .withTransfer),
            
        ]
    }
    
    func convertSettingsIntoConstraints() -> SearchConstraits {
        var result = SearchConstraits() // по дефолту всё true
        settings.forEach { item in
            switch item.section {
            case .time:
                switch item.name {
                case .morning:
                    result.includingMorning = item.isSelected
                case .day:
                    result.includingDay = item.isSelected
                case .evening:
                    result.includingEvening = item.isSelected
                case .night:
                    result.includingNight = item.isSelected
                default:
                    break
                }
            case .withTransfer:
                switch item.name {
                case .no:
                    result.includingWithTransfer = !item.isSelected
                default:
                    result.includingWithTransfer = item.isSelected
                }
            }
        }
        
        // если так получилось, что у нас все false, то мы считаем, что все true
        if !(result.includingMorning || result.includingDay || result.includingEvening || result.includingNight) {
            result.includingMorning = true
            result.includingDay = true
            result.includingEvening = true
            result.includingNight = true
            
        }
        
        return result
        
    }
}

