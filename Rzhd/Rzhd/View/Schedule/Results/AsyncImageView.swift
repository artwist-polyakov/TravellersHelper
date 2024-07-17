//
//  AsyncImageView.swift
//  Rzhd
//
//  Created by Александр Поляков on 16.07.2024.
//

import SwiftUI

struct AsyncImageView: View {
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
           .onAppear(perform: loadImage)
       }
       
       private func loadImage() {
           guard let url = url else {
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
