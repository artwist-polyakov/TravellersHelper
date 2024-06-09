//
//  StoryPreview.swift
//  Rzhd
//
//  Created by Александр Поляков on 06.06.2024.
//

import SwiftUI


struct StoryPreview: View {
    var story: StoriesPack
    let frameWidth: CGFloat = 92
    let frameHeight: CGFloat = 140
    let cornerRadius: CGFloat = 16
    let lineWidth: CGFloat = 4
    
    
    var body: some View {
        
        ZStack {
            
            if let image = story.backgroundPreviewUri {
                Image(image)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: frameWidth, height: frameHeight)
                    .cornerRadius(cornerRadius)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .strokeBorder( story.isViewed ? .clear : .blueUniversal, lineWidth: lineWidth))
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(story.backgroundColor)
                    .frame(width: frameWidth, height: frameHeight)
                    
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .strokeBorder( story.isViewed ? .clear : .blueUniversal, lineWidth: lineWidth))
            }
            VStack  {
                Spacer()
                Text(story.title)
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
//                    .lineLimit(2)
                
                Text(story.description ?? "")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.bottom, 12)
                    .lineLimit(1)
            
                
                
            }
        }.opacity(story.isViewed ? 0.5 : 1.0)
        .frame(width: frameWidth, height: frameHeight)
        
    }
}

#Preview {
    StoryPreview(story: .storiesPack1 )
}
