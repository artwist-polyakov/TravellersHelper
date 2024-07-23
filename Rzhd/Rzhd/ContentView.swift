//
//  ContentView.swift
//  Rzhd
//
//  Created by Александр Поляков on 01.03.2024.
//

import SwiftUI
import OpenAPIURLSession
import HTTPTypes
import Foundation

// MARK: - ContentView
struct ContentView: View, @unchecked Sendable {
    @StateObject var searchData = SearchData()
    @ObservedObject var themeViewModel = DarkThemeViewModel.shared
    @State private var selectedTab = 0
    @ObservedObject var router: PathRouter = PathRouter.shared
    @State private var path: [NavigationIdentifiers] = []
    @State private var stories = StoriesPack.stories
    @State private var storiesMemo = StoriesMemoization() // тут просится вьюмодель
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            TabView(selection: $selectedTab) {
                
                ScheduleView(stories: $stories,memo: $storiesMemo).environmentObject(searchData)
                    .tabItem {
                        Image("ScheduleIcon")
                            .renderingMode(.template)
                    }.overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray).padding(.bottom, 12),
                        alignment: .bottom
                    )
                    .tag(0)
                    .toolbarBackground(Color("TabBarColor"), for: .tabBar)
                SettingsView()
                    .tabItem {
                        Image("SettingsIcon")
                            .renderingMode(.template)
                    }  .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray).padding(.bottom, 12),
                        alignment: .bottom
                        
                    )
                    .tag(0)
                    .edgesIgnoringSafeArea(.top)
                    .toolbarBackground(Color("TabBarColor"), for: .tabBar)
            }.accentColor(.colorOnPrimary)
                .environmentObject(searchData)
                .navigationDestination(for: NavigationIdentifiers.self) { id in
                    switch (id) {
                    case .citiesList:
                        CitiesView().environmentObject(searchData)
                    case .stationsList:
                        StationsView().environmentObject(searchData)
                    case .searchResultsList:
                        SearchResultView().environmentObject(searchData)
                    case .filterList:
                        FilterView().environmentObject(searchData)
                    case .detailedTransporter:
                        TransporterView().environmentObject(searchData)
                    case .agreement:
                        AgreementView()
                    case .stories:
                        StoriesView(
                            stories: $stories,
                            memo: $storiesMemo)
                    }
                }
        }.preferredColorScheme(themeViewModel.themeConfig.isDarkMode ? .dark : .light)
            .background(Color.colorPrimary.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    ContentView()
}
