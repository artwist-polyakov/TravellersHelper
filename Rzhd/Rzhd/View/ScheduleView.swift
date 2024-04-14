//
//  ScheduleView.swift
//  Rzhd
//
//  Created by Александр Поляков on 12.04.2024.
//

import SwiftUI

struct ScheduleView: View {
    @State private var fromText: String = ""
    @State private var toText: String = ""
    var body: some View {
        VStack {
            Spacer()
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(Color.searchBackground)
                    .frame(height: 128)
                    .cornerRadius(20)
                HStack {
                    VStack {
                        TextField("Откуда", text: $fromText)
                            .font(.system(size: 17))
                            .foregroundColor(.black)
                            .foregroundColor(.gray)
                            .textFieldStyle(.plain)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.horizontal, .top])
                            .multilineTextAlignment(.leading)
                        Spacer()
                        
                        TextField("Куда", text: $toText)
                            .font(.system(size: 17))
                            .foregroundColor(.black)
                            .foregroundColor(.gray)
                            .textFieldStyle(.plain)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.horizontal, .top])
                            .multilineTextAlignment(.leading)

                        Spacer()
                    }
                    .frame(height: 96)
                    .background(Color.white.cornerRadius(20))
                    .padding(16) // Отступ слева
                    
                    
                    
                    
                    Image("Refresh")
                        .renderingMode(.template)
                    
                        .frame(width: 36, height: 36)
                    
                        .background(Circle().fill(Color.white))
                        .padding(.trailing, 32)
                }
                .frame(height: 128)
            }
            .padding(.horizontal, 10)
            Spacer()
        }
    }
}


#Preview {
    ScheduleView()
}
