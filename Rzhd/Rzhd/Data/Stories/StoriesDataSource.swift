//
//  StoriesDataSource.swift
//  Rzhd
//
//  Created by Александр Поляков on 14.07.2024.
//

import Foundation

final class StoriesDataSource {
    static let shared = StoriesDataSource()
    private var stories = StoriesPack.stories
}
