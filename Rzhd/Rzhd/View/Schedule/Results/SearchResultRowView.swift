//
//  SearchResultRowView.swift
//  Rzhd
//
//  Created by Александр Поляков on 21.04.2024.
//

import SwiftUI

struct SearchResultRowView: View {
    var searchItem: SearchResult
    
    var body: some View {
        let timeDelta = Int(searchItem.arrivalTime.timeIntervalSince(searchItem.departureTime)/(60*60))
        ZStack {
            Rectangle()
                .fill(Color.greyColor)
                .cornerRadius(24)
            VStack {
                HStack {
                    searchItem.transporter.getLogo()
                        .resizable()
                        .scaledToFit()
                        .frame(width: 38, height: 38)
                        .cornerRadius(12)
                    VStack(alignment: .leading) {
                        Text(searchItem.transporter.name)
                            .font(.system(size: 17))
                            .foregroundColor(.blackUniversal)
                        
                        if (searchItem.transferComment != ""){
                            Spacer()
                            Text(searchItem.transferComment)
                                .font(.system(size: 12))
                            .foregroundColor(.red)}
                    }
                    Spacer()
                    VStack {
                        Text(searchItem.departureTime.toNumberAndMonthRussian())
                            .font(.system(size: 12))
                            .foregroundColor(.blackUniversal)
                        Spacer()
                    }
                    
                }.frame(height: 36)
                Spacer()
                HStack {
                    Text(searchItem.departureTime.toTime()).foregroundColor(.blackUniversal)
                    Spacer()
                        .overlay(Rectangle().fill(Color.rzhdGrayUniversal).frame(height: 1)).padding(4)
                    Text( // delta time
                        String.localizedStringWithFormat(
                            NSLocalizedString("hoursDelta", comment: "hours between arrival and departure"),
                            timeDelta
                        )
                    ).foregroundColor(.blackUniversal)
                    Spacer()
                        .overlay(Rectangle().fill(Color.rzhdGrayUniversal).frame(height: 1)).padding(4)
                    Text(searchItem.arrivalTime.toTime()).foregroundColor(.blackUniversal)
                    
                }
            }.padding(14)
        }.frame(height: 104).padding(.vertical, 4)
    }
}

#Preview {
    SearchResultRowView(searchItem: SearchResult.generateRandom())
}
