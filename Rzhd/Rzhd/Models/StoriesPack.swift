//
//  StoriesPack.swift
//  Rzhd
//
//  Created by Александр Поляков on 07.06.2024.
//

import SwiftUI

struct StoriesPack : Hashable, Identifiable {
    
    var id = UUID()
    let backgroundPreviewUri: String?
    let backgroundColor: Color // на случай если нет изображения
    let title: String
    let description: String?
    let content: [Story]
    var isViewed: Bool = false
    var resumeFrom: Int = 0
    
    static let storiesPack1 = StoriesPack(backgroundPreviewUri: "StoryPr1", backgroundColor: .redUniversal, title: "Как пользоваться приложением?", description: "В этом руководстве вы узнаете как пользоваться приложением и какие возможности оно предоставляет.", content: Story.stories1, isViewed: false)
    static let storiesPack2 = StoriesPack(backgroundPreviewUri: nil, backgroundColor: .redUniversal, title: "Как пользоваться поиском?", description: "В этом руководстве вы узнаете как пользоваться поиском и какие возможности он предоставляет.", content: Story.stories2)
    static let storiesPack3 = StoriesPack(backgroundPreviewUri: "StoryPr3", backgroundColor: .redUniversal, title: "Как пользоваться фильтром?", description: "В этом руководстве вы узнаете как пользоваться фильтром и какие возможности он предоставляет.", content: Story.stories3)
    static let storiesPack4 = StoriesPack(backgroundPreviewUri: "StoryPr4", backgroundColor: .redUniversal, title: "Как пользоваться картой?", description: "В этом руководстве вы узнаете как пользоваться картой и какие возможности она предоставляет.", content: Story.stories4)
    static let storiesPack5 = StoriesPack(backgroundPreviewUri: "StoryPr5", backgroundColor: .redUniversal, title: "Как пользоваться профилем?", description: "В этом руководстве вы узнаете как пользоваться профилем и какие возможности он предоставляет.", content: Story.stories5)
    static let storiesPack6 = StoriesPack(backgroundPreviewUri: "StoryPr6", backgroundColor: .redUniversal, title: "Как пользоваться настройками?", description: "В этом руководстве вы узнаете как пользоваться настройками и какие возможности они предоставляют.", content: Story.stories6)
    static let storiesPack7 = StoriesPack(backgroundPreviewUri: "StoryPr7", backgroundColor: .redUniversal, title: "Как пользоваться уведомлениями?", description: "В этом руководстве вы узнаете как пользоваться уведомлениями и какие возможности они предоставляют.", content: Story.stories7)
    static let storiesPack8 = StoriesPack(backgroundPreviewUri: "StoryPr8", backgroundColor: .redUniversal, title: "Как пользоваться покупками?", description: "В этом руководстве вы узнаете как пользоваться покупками и какие возможности они предоставляют.", content: Story.stories8)
    static let storiesPack9 = StoriesPack(backgroundPreviewUri: "StoryPr9", backgroundColor: .redUniversal, title: "Как пользоваться билетами?", description: "В этом руководстве вы узнаете как пользоваться билетами и какие возможности они предоставляют.", content: Story.stories9)
    static let stories = [storiesPack1, storiesPack2, storiesPack3, storiesPack4, storiesPack5, storiesPack6, storiesPack7, storiesPack8, storiesPack9]
    
}
