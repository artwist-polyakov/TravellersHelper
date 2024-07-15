//
//  ScheduleView.swift
//  Rzhd
//
//  Created by Александр Поляков on 12.04.2024.
//

import SwiftUI

struct ScheduleView: View {
    @ObservedObject var router = PathRouter.shared
    @StateObject private var viewModel = ScheduleViewModel()
    @EnvironmentObject var searchData: SearchData
    
    @Binding var stories: [StoriesPack]
    @Binding var memo: StoriesMemoization
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            Spacer()
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(Array(stories.enumerated()), id: \.element.id) { index, story in
                        StoryPreview(story: story)
                            .onTapGesture {
                                memo.selectedPack = UInt8(index)
                                router.pushPath(.stories)
                            }
                    }
                }}
            .frame(height: 140)
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
            
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(Color.searchBackground)
                    .frame(height: 128)
                    .cornerRadius(20)
                HStack {
                    VStack {
                        Text(searchData.fromText.isEmpty ? "Откуда" : searchData.fromText)
                            .font(.system(size: 17))
                            .foregroundColor(searchData.fromText.isEmpty ? .gray : .black)
                            .textFieldStyle(.plain)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.horizontal, .top])
                            .multilineTextAlignment(.leading)
                            .onTapGesture {
                                checkDataAndNavigate(.from)
                            }
                        Spacer()
                        
                        Text(searchData.toText.isEmpty ? "Куда" : searchData.toText)
                            .font(.system(size: 17))
                            .foregroundColor(searchData.toText.isEmpty ? .gray : .black)
                            .textFieldStyle(.plain)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.horizontal, .top])
                            .multilineTextAlignment(.leading)
                            .onTapGesture {
                                checkDataAndNavigate(.to)
                            }
                        
                        Spacer()
                    }
                    .frame(height: 96)
                    .background(Color.white.cornerRadius(20))
                    .padding(.horizontal, 16) // Отступ слева
                    
                    
                    
                    
                    Image("Refresh")
                        .renderingMode(.template).foregroundColor(.searchBackground)
                    
                        .frame(width: 36, height: 36)
                    
                        .background(Circle().fill(Color.white))
                        .padding(.trailing, 32)
                        .onTapGesture {
                            
                            swapFromTo()
                        }
                }
                .frame(height: 128)
            }
            .padding(.horizontal, 10)
            if !((searchData.cityFrom == nil || searchData.cityTo == nil)) {
                Button {
                    if (searchData.cityFrom == nil || searchData.cityTo == nil) {
                        return
                    }
                    self.router.pushPath(.searchResultsList)
                } label: {
                    Text("Найти")
                        .foregroundColor(.white)
                        .font(.system(size: 17)).bold()
                        .frame(maxWidth: 150)
                        .frame(height: 60)
                        .background(Color.searchBackground)
                        .cornerRadius(16)
                        .padding(.top, 8)
                }
                
            }
            Spacer()
            
        }
        .background(Color.colorPrimary.edgesIgnoringSafeArea(.all))
        .alert("Загрузка данных", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Данные о станциях еще загружаются. Пожалуйста, подождите.")
        }
    }
}

extension ScheduleView {
    func swapFromTo() {
        swap(&searchData.cityFrom, &searchData.cityTo)
        swap(&searchData.stationFrom, &searchData.stationTo)
        swap(&searchData.fromText, &searchData.toText)
    }
}

extension ScheduleView {
    private func checkIsStationsReady() async -> Bool {
        return await viewModel.isDataLoaded()
    }
    
    private func checkDataAndNavigate(_ textField: CurrentlySelectedTextField) {
            Task {
                let isReady = await checkIsStationsReady()
                await MainActor.run {
                    if isReady {
                        searchData.currentlySelectedTextField = textField
                        self.router.pushPath(.citiesList)
                    } else {
                        showingAlert = true
                    }
                }
            }
        }
}



#Preview {
    ScheduleView(stories: .constant(StoriesPack.stories),
                 memo: .constant(StoriesMemoization())
    )
    .environmentObject(SearchData())
}
