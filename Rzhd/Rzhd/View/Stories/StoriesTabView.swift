//
//  StoriesTabView.swift
//  Rzhd
//
//  Created by Александр Поляков on 07.06.2024.
//

import SwiftUI

struct StoriesTabView: View {
    let stories: [Story]
    @Binding var currentStoryIndex: Int
    var nextStoryPackCompletion: (Bool) -> Void
    
    var body: some View {
        TabView(selection: $currentStoryIndex) {
            ForEach(stories.indices, id: \.self) { index in
                StoryView(story: stories[index],
                          onSwipeLeft: {
                    withAnimation {
                        if currentStoryIndex == stories.count - 1 {
                            nextStoryPackCompletion(false)
                        } else {
                            currentStoryIndex = min(currentStoryIndex + 1, stories.count - 1)
                        }}
                })
                .tag(index)
                .onTapGesture { value in
                    if value.x < UIScreen.main.bounds.width / 2 {
                        didTapStory(back: true)
                    } else {
                        didTapStory()
                    }}
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
    
    func didTapStory(back: Bool = false) {
        switch back {
        case true:
            withAnimation {
                if currentStoryIndex > 0 {
                    currentStoryIndex -= 1
                } else {
                    nextStoryPackCompletion(true)
                }
            }
        case false:
            withAnimation {
                if currentStoryIndex == stories.count - 1 {
                    nextStoryPackCompletion(false)}
                else {
                    currentStoryIndex = min(currentStoryIndex + 1, stories.count - 1)
                }
            }
        }
    }
}
