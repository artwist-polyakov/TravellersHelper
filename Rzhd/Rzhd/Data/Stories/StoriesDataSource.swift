//
//  StoriesDataSource.swift
//  Rzhd
//
//  Created by Александр Поляков on 14.07.2024.
//

import Foundation

final class StoriesDataSource: @unchecked Sendable {
    static let shared = StoriesDataSource()
    private var stories = StoriesPack.stories
    private var storiesMemo = StoriesMemoization()
    
    
    func getStories() -> [StoriesPack] {
        self.stories
    }
    
    func getCurrentPosition() -> UInt8 {
        self.storiesMemo.selectedPack
    }
    
    func setCurrentPosition(_ position: UInt8) {
        self.storiesMemo.selectedPack = position
    }
}
