//
//  SelectionModel.swift
//  Rzhd
//
//  Created by Александр Поляков on 22.04.2024.
//

import Foundation
import SwiftUI

enum FilterSection: String, CaseIterable {
    case time = "Время отправления"
    case withTransfer = "Показывать варианты с пересадками"
}

enum NameCases: String, CaseIterable {
    case morning = "Утро 06:00 - 12:00"
    case day = "День 12:00 - 18:00"
    case evening = "Вечер 18:00 - 00:00"
    case night = "Ночь 00:00 - 06:00"
    case yes = "Да"
    case no = "Нет"
}



class SelectionModel  : Hashable, Identifiable, ObservableObject {
    var id = UUID()
    var name: NameCases
    @Published var isSelected: Bool = false
    private let isRadio: Bool
    var section: FilterSection
    
    init (
        name: NameCases,
        isSelected: Bool = false,
        isRadio: Bool = false,
        section: FilterSection = .time
    ) {
        self.name = name
        self.isSelected = isSelected
        self.isRadio = isRadio
        self.section = section
    }
    
    
    static func == (lhs: SelectionModel, rhs: SelectionModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func isRadioButton() -> Bool {
        return self.isRadio
    }
    
    func getImage() -> Image {
        switch (self.isRadio) {
        case true:
            return self.isSelected ? Image("RadioSelected") : Image("RadioUnselected")
        case false:
            return self.isSelected ? Image("CheckboxSelected") : Image("CheckboxUnselected")
        }
    }
}
