//
//  StoryView.swift
//  Rzhd
//
//  Created by Александр Поляков on 07.06.2024.
//

import SwiftUI

struct StoryView: View {
    let story: Story
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(.black)
            if let image = story.backgroundImageUri {
                Image(image)
                
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
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
        
    }
}

#Preview {
    StoryView(story: .story12)
}
