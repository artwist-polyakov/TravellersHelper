//
//  AsyncImageView.swift
//  Rzhd
//
//  Created by Александр Поляков on 16.07.2024.
//

import SwiftUI

struct AsyncImageView: View {
    let url: URL?
    let defaultImage: Image = Image("LogoPlaceholder")
    
    @State private var image: UIImage?
    @State private var isLoading = false
    
    init(url: URL?) {
        self.url = url
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
           .onAppear(perform: loadImage)
       }
       
       private func loadImage() {
           guard let url = url else {
               // If URL is nil, we don't need to load anything
               return
           }
           
           guard !isLoading else { return }
           
           isLoading = true
           URLSession.shared.dataTask(with: url) { data, response, error in
               defer { isLoading = false }
               
               guard let data = data, error == nil else {
                   print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                   return
               }
               
               if let loadedImage = UIImage(data: data) {
                   DispatchQueue.main.async {
                       self.image = loadedImage
                   }
               }
           }.resume()
       }
}
