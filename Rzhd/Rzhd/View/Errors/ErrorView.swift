//
//  ErrorView.swift
//  Rzhd
//
//  Created by Александр Поляков on 23.04.2024.
//

import SwiftUI

struct ErrorView: View {
    let error: ErrorModel
    
    
    var body: some View {
        VStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            error.getImage()
                .resizable()
                .frame(width: 223, height: 223)
                .scaledToFit()
                .cornerRadius(70)
                .padding(.bottom, 16)
            Text(error.message)
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)
            
            
        }
    }
}

#Preview {
    ErrorView(error: ErrorModel.forState(.noInternet))
//    ErrorView(error: ErrorModel.forState(.internalError))
}
