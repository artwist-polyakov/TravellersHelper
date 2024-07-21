//
//  AsyncImageView.swift
//  Rzhd
//
//  Created by Александр Поляков on 16.07.2024.
//

import SwiftUI

struct AsyncImageView: View, @unchecked Sendable {
    let url: URL?
    let defaultImage: Image
    
    @State private var image: UIImage?
    @State private var isLoading = false
    
    init(url: URL?, placeholder: Image = Image("LogoPlaceholder")) {
        self.url = url
        self.defaultImage = placeholder
    }
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if isLoading {
                ProgressView()
            } else {
                defaultImage
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            }
        }
        .task {
            await loadImage()
        }
    }
    
    private func loadImage() async {
        guard let url = url else {
            return
        }
        
        guard !isLoading else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let loadedImage = UIImage(data: data) {
                await MainActor.run {
                    self.image = loadedImage
                }
            }
        } catch {
            print("Error loading image: \(error.localizedDescription)")
        }
    }
}
