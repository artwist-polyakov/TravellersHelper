//
//  CheckbocksSettingsRowView.swift
//  Rzhd
//
//  Created by Александр Поляков on 22.04.2024.
//

import SwiftUI

struct CheckbocksSettingsRowView: View {
    
    @StateObject var model: SelectionModel
    
    var body: some View {
        HStack {
            Text(model.name).font(.system(size:17))
            Spacer()
            //adding checkbocks
            Toggle(isOn: $model.isSelected) {
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
    }
}

#Preview {
    CheckbocksSettingsRowView(model: SelectionModel(name: "До полудня"))
}
