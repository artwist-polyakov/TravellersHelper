//
//  CloseButton.swift
//  Rzhd
//
//  Created by Александр Поляков on 07.06.2024.
//

import SwiftUI

struct CloseButton: View {
    let action: () -> Void

    var body: some View {
        Button("", image: .close) {
            action()
        }
    }
}


