//
//  SearchResultView.swift
//  Rzhd
//
//  Created by Александр Поляков on 22.04.2024.
//

import SwiftUI

struct SearchResultView: View {
    
    @EnvironmentObject var searchData: SearchData
    
    @Binding var path: [NavigationIdentifiers]
    
    @StateObject var viewModel = SearchResultViewModel()
    
    var body: some View {
        ZStack (alignment: .topLeading)  {
            VStack(alignment: .leading) {
                ZStack {
                    VStack{
                        HStack (alignment:.top) {
                            Text(searchData.fromText + " → " + searchData.toText).multilineTextAlignment(.leading)
                                .font(.system(size: 24)).bold()
                                .foregroundColor(.colorOnPrimary)
                                .padding(.top, 16)
                                .padding(.bottom, 8)
                            Spacer()}
                        if viewModel.searchResult.isEmpty {
                            Spacer()}
                    }.background(Color.colorPrimary)
                    
                }
                if viewModel.searchResult.isEmpty {
                    VStack {
                        Text("Вариантов нет")
                            .font(.system(size: 24))
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                    } // VSTACK ALERT
                    
                } else {
                    ScrollView (showsIndicators: false) {
                        LazyVStack(spacing: 0) {
                            ForEach(viewModel.searchResult) { element in
                                SearchResultRowView(searchItem: element)
                                    .onTapGesture {
                                        path.append(.detailedTransporter)
                                    }
                                
                            }
                        }
                        
                    }}
            }
            VStack {
                Spacer()
                Button(action: {
                    self.path.append(.filterList)
                }) {
                    HStack (alignment: .center)  {
                        Text("Уточнить время")
                            .foregroundColor(.white)
                            .font(.system(size: 17)).bold()
                    }
                    if !searchData.filterConstraints.isDefault(){
                        VStack {
                            Spacer()
                            Circle()
                                .frame(width: 8, height: 8)
                                .foregroundColor(.redUniversal)
                            Spacer()
                        }}
                }.frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(.blue)
                    .cornerRadius(16)
                    .padding(.bottom, 24)
            }
            
        }.padding(.horizontal, 16)
            .background(Color.colorPrimary.edgesIgnoringSafeArea(.all))
            .navigationBarTitleDisplayMode(.inline)
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

