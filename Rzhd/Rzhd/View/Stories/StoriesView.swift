//
//  StoriesView.swift
//  Rzhd
//
//  Created by Александр Поляков on 07.06.2024.
//

import SwiftUI

struct StoriesView: View {
    @Binding var stories: [StoriesPack]
    @Binding var memo: StoriesMemoization
    @Binding var path: [NavigationIdentifiers]
    @State var currentStoryIndex: Int = 0
    @State var currentProgress: CGFloat = 0
    
    private func nextStoryPackCompletion() {
        if Int(memo.selectedPack) < stories.count - 1 {
            withAnimation(.easeInOut) {
                memo.selectedPack += 1
                currentStoryIndex = 0
                currentProgress = 0
            }
        } else {
            if !path.isEmpty {
                path.removeLast()
            }
        }
    }
    
    private var timerConfiguration: TimerConfiguration {
        .init(
            storiesCount: stories[Int(memo.selectedPack)].content.count
        )
        
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesTabView(stories: stories[Int(memo.selectedPack)].content, currentStoryIndex: $currentStoryIndex,
                           nextStoryPackCompletion: nextStoryPackCompletion
            )
            .onChange(of: currentStoryIndex) { oldValue, newValue in
                didChangeCurrentIndex(oldIndex: oldValue, newIndex: newValue)
            }.ignoresSafeArea()
            
            StoriesProgressBar(
                storiesCount: stories[Int(memo.selectedPack)].content.count,
                timerConfiguration: timerConfiguration,
                currentProgress: $currentProgress
            )
            .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            .onChange(of: currentProgress) { _, newValue in
                didChangeCurrentProgress(newProgress: newValue)
            }
            CloseButton(action: { if !path.isEmpty { path.removeLast() } })
                .padding(.top, 57)
                .padding(.trailing, 12)
        }.navigationBarHidden(true)
    }
    
    private func didChangeCurrentIndex(oldIndex: Int, newIndex: Int) {
        guard oldIndex != newIndex else { return }
        let progress = timerConfiguration.progress(for: newIndex)
        stories[Int(memo.selectedPack)].content[oldIndex].isViewed = true
        stories[Int(memo.selectedPack)].content[newIndex].isViewed = true
        if (allStoriesViewed()) {
            stories[Int(memo.selectedPack)].isViewed = true
        }
        guard abs(progress - currentProgress) >= 0.01 else { return }
        withAnimation {
            currentProgress = progress
        }
        
        if allStoriesViewed() {
            stories[Int(memo.selectedPack)].isViewed = true
        }
    }
    
    private func didChangeCurrentProgress(newProgress: CGFloat) {
        
        if newProgress == 1.0 {
            if Int(memo.selectedPack) < stories.count - 1 {
                withAnimation(.easeInOut) {
                    memo.selectedPack += 1
                    currentStoryIndex = 0
                    currentProgress = 0
                }
            } else {
                if !path.isEmpty {
                    path.removeLast()
                }
            }
            return
        }
        
        let index = timerConfiguration.index(for: newProgress)
        guard index != currentStoryIndex else { return }
        withAnimation {
            
            currentStoryIndex = index
        }
    }
    
    private func allStoriesViewed() -> Bool {
        for story in stories[Int(memo.selectedPack)].content where !story.isViewed {
            return false
        }
        return true
    }
}


struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesView(
            stories: .constant(StoriesPack.stories),
            memo: .constant(StoriesMemoization()), path: .constant([]))
    }
}
