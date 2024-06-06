//
//  Story.swift
//  Rzhd
//
//  Created by Александр Поляков on 05.06.2024.
//

import SwiftUI

struct Story {
    let id: Int
    let backgroundImageUri: String?
    let backgroundPreviewUri: String?
    let backgroundColor: Color // на случай если нет изображения
    let title: String
    let description: String?
    var isViewed: Bool = false
    
    static let story1 = Story(id: 1, backgroundImageUri: "StoryBg1", backgroundPreviewUri: "StoryPr1", backgroundColor: .redUniversal, title: "Как пользоваться приложением?", description: "В этом руководстве вы узнаете как пользоваться приложением и какие возможности оно предоставляет.", isViewed: true)
    static let story2 = Story(id: 2, backgroundImageUri: "StoryBg3", backgroundPreviewUri: nil, backgroundColor: .redUniversal, title: "Как пользоваться поиском?", description: "В этом руководстве вы узнаете как пользоваться поиском и какие возможности он предоставляют.")
    static let story3 = Story(id: 3, backgroundImageUri: "StoryBg5", backgroundPreviewUri: "StoryPr3", backgroundColor: .redUniversal, title: "Как пользоваться фильтром?", description: "В этом руководстве вы узнаете как пользоваться фильтром и какие возможности он предоставляет.")
    static let story4 = Story(id: 4, backgroundImageUri: "StoryBg7", backgroundPreviewUri: "StoryPr4", backgroundColor: .redUniversal, title: "Как пользоваться картой?", description: "В этом руководстве вы узнаете как пользоваться картой и какие возможности она предоставляет.")
    static let story5 = Story(id: 5, backgroundImageUri: "StoryBg9", backgroundPreviewUri: "StoryPr5", backgroundColor: .redUniversal, title: "Как пользоваться профилем?", description: "В этом руководстве вы узнаете как пользоваться профилем и какие возможности он предоставляет.")
    static let story6 = Story(id: 6, backgroundImageUri: "StoryBg11", backgroundPreviewUri: "StoryPr6", backgroundColor: .redUniversal, title: "Как пользоваться настройками?", description: "В этом руководстве вы узнаете как пользоваться настройками и какие возможности они предоставляют.")
    static let story7 = Story(id: 7, backgroundImageUri: "StoryBg13", backgroundPreviewUri: "StoryPr7", backgroundColor: .redUniversal, title: "Как пользоваться уведомлениями?", description: "В этом руководстве вы узнаете как пользоваться уведомлениями и какие возможности они предоставляют.")
    static let story8 = Story(id: 8, backgroundImageUri: "StoryBg15", backgroundPreviewUri: "StoryPr8", backgroundColor: .redUniversal, title: "Как пользоваться покупками?", description: "В этом руководстве вы узнаете как пользоваться покупками и какие возможности они предоставляют.")
    static let story9 = Story(id: 9, backgroundImageUri: "StoryBg17", backgroundPreviewUri: "StoryPr9", backgroundColor: .redUniversal, title: "Как пользоваться билетами?", description: "В этом руководстве вы узнаете как пользоваться билетами и какие возможности они предоставляют.")
    static let stories = [story1, story2, story3, story4, story5, story6, story7, story8, story9]

}
