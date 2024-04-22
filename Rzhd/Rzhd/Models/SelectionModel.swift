//
//  SelectionModel.swift
//  Rzhd
//
//  Created by Александр Поляков on 22.04.2024.
//

import Foundation
import SwiftUI

class SelectionModel  : Hashable, Identifiable, ObservableObject {
    var id = UUID()
    var name: String = ""
    var isSelected: Bool = false
    private let isRadio: Bool
    
    init (name: String, isSelected: Bool = false, isRadio: Bool = false) {
        self.name = name
        self.isSelected = isSelected
        self.isRadio = isRadio
    }
    
    
    static func == (lhs: SelectionModel, rhs: SelectionModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
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
