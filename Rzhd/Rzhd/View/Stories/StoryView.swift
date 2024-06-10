//
//  StoryView.swift
//  Rzhd
//
//  Created by Александр Поляков on 07.06.2024.
//

import SwiftUI

struct StoryView: View {
    let story: Story
    let onSwipeLeft: () -> Void
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
                .ignoresSafeArea()
            if let image = story.backgroundImageUri {
                Image(image)
                
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .padding(.vertical, 51)
            } else {
                RoundedRectangle(cornerRadius: 40)
                    .foregroundColor(story.backgroundColor)
                    .padding(.vertical, 51)
            }
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    Text(story.title)
                        .font(.storyTitle)
                        .foregroundColor(.white)
                    Text(story.description ?? "")
                        .font(.storyText)
                        .lineLimit(3)
                        .foregroundColor(.white)
                }
                .padding(.init(top: 0, leading: 16, bottom: 91, trailing: 16))
            }.ignoresSafeArea()
        } .ignoresSafeArea()
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.width < -50 {
                            onSwipeLeft()
                        }
                    }
            )
    }
}

#Preview {
    StoryView(story: .story11, onSwipeLeft: {})
}
