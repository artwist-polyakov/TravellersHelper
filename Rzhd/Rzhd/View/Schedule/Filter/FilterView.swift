//
//  FilterView.swift
//  Rzhd
//
//  Created by Александр Поляков on 22.04.2024.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject var searchData: SearchData
    private var router: PathRouter = PathRouter.shared
    @ObservedObject var viewModel = FilterViewModel()
    
    var body: some View {
        
        ZStack{
            
            ScrollView (showsIndicators: false) {
                LazyVStack {
                    ForEach(FilterSection.allCases, id: \.self) {type in
                        Section(header: HeaderView(header: type.rawValue)) {
                            ForEach(viewModel.settings) { setting in
                                if setting.section == type {
                                    CheckboxSettingsRowView(model: setting)
                                        .onTapGesture {
                                            viewModel.onTap(model: setting)
                                        }
                                    
                                }
                            }
                        }
                    }
                }
            }
            VStack {
                Spacer()
                Button(action: {
                    searchData.filterConstraints = viewModel.convertSettingsIntoConstraints()
                    if !router.isEmpty() {
                        router.popPath()
                    }
                }) {
                    Text("Применить")
                        .foregroundColor(.white)
                        .font(.system(size: 17)).bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(.blue)
                        .cornerRadius(16)
                        .padding(.bottom, 24)
                }
            }
        }.onAppear {
            let filterConstraints = searchData.filterConstraints
            viewModel.configureConstraints(constraints: filterConstraints)
        }
        
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden(true).background(Color.colorPrimary.edgesIgnoringSafeArea(.all))
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    searchData.currentlySelectedTextField = .nothing
                    self.router.popPath()
                }) {
                    Image( "NavBackButton")
                        .foregroundColor(Color.rzhdGreyBackButton)
                }
            }
        }
    }
    
}

#Preview {
    FilterView()
        .environmentObject(SearchData())
    
}
