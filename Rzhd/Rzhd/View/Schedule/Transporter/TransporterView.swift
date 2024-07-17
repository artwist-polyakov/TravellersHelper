//
//  TransporterView.swift
//  Rzhd
//
//  Created by Александр Поляков on 22.04.2024.
//

import SwiftUI

struct TransporterView: View {
    @EnvironmentObject var searchData: SearchData
    private var router: PathRouter = PathRouter.shared
    
    @StateObject var viewModel = TransporterViewModel()
    
    func openMail(emailTo:String, subject: String = "", body: String = "") {
        var components = URLComponents()
        components.scheme = "mailto"
        components.path = emailTo
        components.queryItems = [
            URLQueryItem(name: "subject", value: subject),
            URLQueryItem(name: "body", value: body)
        ]
        
        if let url = components.url {
            openUrl(url)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if viewModel.isLoading {
                ProgressView("Загрузка результатов...")
            } else {
                AsyncImageView(url: viewModel.getLogo(), placeholder: Image("BigLogoPlaceholder"))
                    .frame(height: 104)
                    .scaledToFit()
                    .cornerRadius(24)
                    .padding(.vertical, 16)
                
                Text(viewModel.transporter?.name ?? "")
                    .font(.system(size: 24)).bold()
                    .foregroundColor(.colorOnPrimary)
                    .padding(.bottom, 16)
                Text("E-mail")
                    .font(.system(size: 17))
                    .foregroundColor(.colorOnPrimary)
                Text(viewModel.transporter?.email ?? "")
                    .font(.system(size: 12))
                    .foregroundColor(.searchBackground)
                    .padding(.bottom, 12)
                    .onTapGesture {
                        guard let email = viewModel.transporter?.email else {return}
                        openMail(emailTo: email)
                    }
                Text("Телефон")
                    .font(.system(size: 17))
                    .foregroundColor(.colorOnPrimary)
                    .padding(.top, 12)
                Text(viewModel.transporter?.phone ?? "")
                    .font(.system(size: 12))
                    .foregroundColor(.searchBackground)
                    .padding(.bottom, 12)
                    .onTapGesture {
                        guard let phone = viewModel.transporter?.phone else {return}
                        let phoneNumber = phone.filter("0123456789+".contains)
                        if let url = URL(string: "tel://\(phoneNumber)") {
                            openUrl(url)
                        }
                    }
                Spacer()
            }
        }.padding(.horizontal, 16)
            .navigationTitle("Информация о перевозчике ").navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .background(Color.colorPrimary.edgesIgnoringSafeArea(.all))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        searchData.currentlySelectedTextField = .nothing
                        self.router.popPath()
                    }) {
                        Image( "NavBackButton")
                            .foregroundColor(Color.rzhdGreyBackButton)
                    }
                }
            }
            .task {
                await viewModel.loadTransporter()
            }
    }
}

extension View {
    func openUrl(_ url: URL?) {
        guard let url = url, UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}

#Preview {
    TransporterView()
}
