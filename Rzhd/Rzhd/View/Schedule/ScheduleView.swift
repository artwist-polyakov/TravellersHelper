//
//  ScheduleView.swift
//  Rzhd
//
//  Created by Александр Поляков on 12.04.2024.
//

import SwiftUI

struct ScheduleView: View {
    
    @Binding var path: [String]
    
    @EnvironmentObject var searchData: SearchData
    
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
                        TextField("Откуда", text: $searchData.fromText)
                            .font(.system(size: 17))
                            .foregroundColor(.black)
                            .foregroundColor(.gray)
                            .textFieldStyle(.plain)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.horizontal, .top])
                            .multilineTextAlignment(.leading)
                            .onTapGesture {
                                searchData.currentlySelectedTextField = .from
                                self.path.append("CitiesList")
                                print(path)
                            }
                        Spacer()
                        
                        TextField("Куда", text: $searchData.toText)
                            .font(.system(size: 17))
                            .foregroundColor(.black)
                        
                            .foregroundColor(.gray)
                            .textFieldStyle(.plain)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.horizontal, .top])
                            .multilineTextAlignment(.leading)
                            .onTapGesture {
                                searchData.currentlySelectedTextField = .to
                                self.path.append("CitiesList")
                                print(path)
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
                    self.path.append("SearchResultsList")
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
    }
}

extension ScheduleView {
    func swapFromTo() {
        swap(&searchData.cityFrom, &searchData.cityTo)
        swap(&searchData.stationFrom, &searchData.stationTo)
        swap(&searchData.fromText, &searchData.toText)
    }
}



#Preview {
    ScheduleView(path: .constant([]))
        .environmentObject(SearchData())
}
