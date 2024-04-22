//
//  CheckbocksSettingsRowView.swift
//  Rzhd
//
//  Created by Александр Поляков on 22.04.2024.
//

import SwiftUI

struct CheckboxSettingsRowView: View {
    
    @StateObject var model: SelectionModel
    
    var body: some View {
        HStack {
            Text(model.name).font(.system(size:17))
            Spacer()
            model.getImage()
        }.frame(height: 60)
    }
}

#Preview {
    CheckboxSettingsRowView(model: SelectionModel(name: "До полудня", isSelected: false, isRadio: true))
}
