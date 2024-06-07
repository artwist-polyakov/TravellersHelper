//
//  Story.swift
//  Rzhd
//
//  Created by Александр Поляков on 05.06.2024.
//

import SwiftUI

struct Story : Hashable, Identifiable {
    var id = UUID()
    let backgroundImageUri: String?
    let backgroundColor: Color// на случай если нет изображения
    let title: String
    let description: String?
    var isViewed: Bool = false
    
    static let story11 = Story(backgroundImageUri: "StoryBg1", backgroundColor: .redUniversal, title: "Как пользоваться приложением?", description: "В этом руководстве вы узнаете как пользоваться приложением и какие возможности оно предоставляет.", isViewed: true)
    static let story12 = Story(backgroundImageUri: nil, backgroundColor: .redUniversal, title: "Как на надо пользоваться приложением?", description: "В этом руководстве вы узнаете как не надо пользоваться приложением и какие возможности оно предоставляет.")
    static let stories1 = [story11, story12]
    static let story21 = Story(backgroundImageUri: "StoryBg3", backgroundColor: .redUniversal, title: "Как пользоваться поиском?", description: "В этом руководстве вы узнаете как пользоваться поиском и какие возможности он предоставляют.")
    static let story22 = Story(backgroundImageUri: "StoryBg4", backgroundColor: .redUniversal, title: "Как на надо искать", description: "В этом руководстве вы узнаете как не надо пользоваться поиском и какие возможности он предоставляет.")
    static let stories2 = [story21, story22]
    static let story31 = Story(backgroundImageUri: "StoryBg5", backgroundColor: .redUniversal, title: "Как пользоваться фильтром?", description: "В этом руководстве вы узнаете как пользоваться фильтром и какие возможности он предоставляет.")
    static let story32 = Story(backgroundImageUri: "StoryBg6", backgroundColor: .redUniversal, title: "Как не пользоваться фильтром?", description: "В этом руководстве вы узнаете как не пользоваться фильтром и какие возможности он не предоставляет.")
    static let stories3 = [story31, story32]
    static let story41 = Story(backgroundImageUri: "StoryBg7",backgroundColor: .redUniversal, title: "Как пользоваться картой?", description: "В этом руководстве вы узнаете как пользоваться картой и какие возможности она предоставляет.")
    static let story42 = Story(backgroundImageUri: "StoryBg8",backgroundColor: .redUniversal, title: "Как не пользоваться картой?", description: "В этом руководстве вы узнаете как на надо пользоваться картой и какие возможности она предоставляет.")
    static let stories4 = [story41, story42]
    static let story51 = Story(backgroundImageUri: "StoryBg9", backgroundColor: .redUniversal, title: "Как пользоваться профилем?", description: "В этом руководстве вы узнаете как пользоваться профилем и какие возможности он предоставляет.")
    static let story52 = Story(backgroundImageUri: "StoryBg10",  backgroundColor: .redUniversal, title: "Как не пользоваться профилем?", description: "В этом руководстве вы узнаете как нельзя пользоваться профилем и какие возможности он предоставляет.")
    static let stories5 = [story51, story52]
    static let story61 = Story(backgroundImageUri: "StoryBg11", backgroundColor: .redUniversal, title: "Как пользоваться настройками?", description: "В этом руководстве вы узнаете как пользоваться настройками и какие возможности они предоставляют.")
    static let story62 = Story(backgroundImageUri: "StoryBg12", backgroundColor: .redUniversal, title: "Как нельзя пользоваться настройками?", description: "В этом руководстве вы не узнаете как пользоваться настройками и какие возможности они предоставляют.")
    static let stories6 = [story61, story62]
    static let story71 = Story(backgroundImageUri: "StoryBg13", backgroundColor: .redUniversal, title: "Как пользоваться уведомлениями?", description: "В этом руководстве вы узнаете как пользоваться уведомлениями и какие возможности они предоставляют.")
    static let story72 = Story(backgroundImageUri: "StoryBg14", backgroundColor: .redUniversal, title: "Как нельзя пользоваться уведомлениями?", description: "В этом не руководстве вы узнаете как пользоваться уведомлениями и какие возможности они предоставляют.")
    static let stories7 = [story71, story72]
    static let story81 = Story(backgroundImageUri: "StoryBg15", backgroundColor: .redUniversal, title: "Как пользоваться покупками?", description: "В этом руководстве вы узнаете как пользоваться покупками и какие возможности они предоставляют.")
    static let story82 = Story(backgroundImageUri: "StoryBg16", backgroundColor: .redUniversal, title: "НЕ Как пользоваться покупками?", description: "В НЕ этом руководстве вы узнаете как пользоваться покупками и какие возможности они предоставляют.")
    static let stories8 = [story81, story82]
    static let story91 = Story(backgroundImageUri: "StoryBg17", backgroundColor: .redUniversal, title: "Как пользоваться билетами?", description: "В этом руководстве вы узнаете как пользоваться билетами и какие возможности они предоставляют.")
    static let story92 = Story(backgroundImageUri: "StoryBg18", backgroundColor: .redUniversal, title: "Как не пользоваться билетами?", description: "В этом руководстве вы узнаете как не пользоваться билетами и какие возможности они предоставляют.")
    static let stories9 = [story91, story92]

}
