//
//  MainViewModel.swift
//  Rzhd
//
//  Created by Александр Поляков on 14.07.2024.
//

import Foundation

@MainActor
final class MainViewModel: ObservableObject {
    private let stationsInteractor = StationsInteractor()
    private let storiesInteractor = StoriesInteractor()
}
