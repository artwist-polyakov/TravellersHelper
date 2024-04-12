//
//  ScheduleView.swift
//  Rzhd
//
//  Created by Александр Поляков on 12.04.2024.
//

import SwiftUI

struct ScheduleView: View {
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(Color.searchBackground)
                    .frame(height: 128)
                    .cornerRadius(20)
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(20)
                    .frame(height: 96)
                    .padding(16) // Отступ слева
                    .padding(.trailing, 68)
                HStack {
                    Spacer()
                    
                    Image("Refresh").renderingMode(.template)
                    
                        .frame(width: 36, height: 36)
                    
                        .background(Circle().fill(Color.blue))
                        .padding(.trailing, 16)
                }
                .frame(height: 128)
            }
            .padding(.horizontal, 10)
            
        }
    }
}


#Preview {
    ScheduleView()
}
