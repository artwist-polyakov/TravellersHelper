//
//  SearchResultView.swift
//  Rzhd
//
//  Created by Александр Поляков on 22.04.2024.
//

import SwiftUI

struct SearchResultView: View {
    
    @EnvironmentObject var searchData: SearchData
    
    @Binding var path: [String]
    
    @StateObject var viewModel = SearchResultViewModel()
    
    var body: some View {
        ZStack (alignment: .topLeading)  {
            VStack(alignment: .leading) {
                HStack (alignment:.top) {
                    Text(searchData.fromText + " → " + searchData.toText).multilineTextAlignment(.leading)
                        .font(.system(size: 24)).bold()
                        .foregroundColor(.colorOnPrimary)
                        .padding(.top, 16)
                        .padding(.bottom, 8)
                Spacer()}
                ScrollView (showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.searchResult) { element in
                            SearchResultRowView(searchItem: element)
                                .onTapGesture {
                                    path.append("DetailedTransporter")
                                }
                            
                        }
                    }
                }
            }
            VStack {
                Spacer()
                Button(action: {
                    self.path.append("FilterList")
                }) {
                    Text("Уточнить время")
                        .foregroundColor(.white)
                        .font(.system(size: 17)).bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(.blue)
                        .cornerRadius(16)
                        .padding(.bottom, 24)
                }
            }
        }.padding(.horizontal, 16).navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    searchData.currentlySelectedTextField = .nothing
                    self.path.removeLast()
                }) {
                    Image( "NavBackButton")
                        .foregroundColor(Color.rzhdGreyBackButton)
                }
            }
        }
    }
}

#Preview {
    // Идиома IILE
    SearchResultView(path: .constant([])).environmentObject({
        let search = SearchData()
        search.fromText = "Москва (Перемерки)"
        search.toText = "Санкт-Петербург (Выворотки)"
        return search
    }())
}
