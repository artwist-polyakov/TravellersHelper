//
//  StoriesView.swift
//  Rzhd
//
//  Created by Александр Поляков on 07.06.2024.
//

import SwiftUI


struct StoriesView: View {
    let stories: [StoriesPack] = StoriesPack.stories
    
    @State var currentStoryIndex: Int = 0
    @State var currentStoriesPackIndex: Int = 4
    @State var currentProgress: CGFloat = 0
    private var timerConfiguration: TimerConfiguration { .init(storiesCount: stories[currentStoriesPackIndex].content.count) }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesTabView(stories: stories[currentStoriesPackIndex].content, currentStoryIndex: $currentStoryIndex)
                .onChange(of: currentStoryIndex) { oldValue, newValue in
                    didChangeCurrentIndex(oldIndex: oldValue, newIndex: newValue)
                }.ignoresSafeArea()

            StoriesProgressBar(
                storiesCount: stories[currentStoriesPackIndex].content.count,
                timerConfiguration: timerConfiguration,
                currentProgress: $currentProgress
            )
            .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            .onChange(of: currentProgress) { _, newValue in
                didChangeCurrentProgress(newProgress: newValue)
            }
        }
    }
    
    
    private func didChangeCurrentIndex(oldIndex: Int, newIndex: Int) {
        guard oldIndex != newIndex else { return }
        let progress = timerConfiguration.progress(for: newIndex)
        guard abs(progress - currentProgress) >= 0.01 else { return }
        withAnimation {
            currentProgress = progress
        }
    }

    private func didChangeCurrentProgress(newProgress: CGFloat) {
        let index = timerConfiguration.index(for: newProgress)
        guard index != currentStoryIndex else { return }
        withAnimation {
            currentStoryIndex = index
        }
    }
    
}


struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesView()
    }
}
