//
//  AgreementView.swift
//  Rzhd
//
//  Created by Александр Поляков on 23.04.2024.
//

import SwiftUI

struct AgreementView: View {
    private var router: PathRouter = PathRouter.shared
    @StateObject private var viewModel = AgreementViewModel.create()
    
    var body: some View {
        WebView(url: URL(string: viewModel.getAgreementLink())!).navigationTitle("Пользовательское соглашение").navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        if !self.router.isEmpty(){
                            self.router.popPath()}
                    }) {
                        Image( "NavBackButton")
                            .foregroundColor(Color.rzhdGreyBackButton)
                    }
                }
            }
    }
}

#Preview {
    AgreementView()
}
