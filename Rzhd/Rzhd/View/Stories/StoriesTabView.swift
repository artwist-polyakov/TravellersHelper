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
    var nextStoryPackCompletion: () -> Void
    
    var body: some View {
        TabView(selection: $currentStoryIndex) {
            ForEach(stories.indices, id: \.self) { index in
                StoryView(story: stories[index],
                          onSwipeLeft: {
                    withAnimation(){
                        if currentStoryIndex == stories.count - 1 {
                            nextStoryPackCompletion()
                        } else {
                            currentStoryIndex = min(currentStoryIndex + 1, stories.count - 1)
                        }}
                })
                .tag(index)
                .onTapGesture {
                    didTapStory()
                }
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
    
    func didTapStory() {
        withAnimation(){
            if currentStoryIndex == stories.count - 1 {
                nextStoryPackCompletion()
            }
            currentStoryIndex = min(currentStoryIndex + 1, stories.count - 1)}
    }
}

