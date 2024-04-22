//
//  SelectionModel.swift
//  Rzhd
//
//  Created by Александр Поляков on 22.04.2024.
//

import Foundation

class SelectionModel  : Hashable, Identifiable, ObservableObject {
    var id = UUID()
    var name: String = ""
    var isSelected: Bool = false
    
    init (name: String, isSelected: Bool = false) {
        self.name = name
        self.isSelected = isSelected
    }
    
    
    static func == (lhs: SelectionModel, rhs: SelectionModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
