//
//  TransporterView.swift
//  Rzhd
//
//  Created by Александр Поляков on 22.04.2024.
//

import SwiftUI

struct TransporterView: View {
    @EnvironmentObject var searchData: SearchData
    
    @Binding var path: [String]
    
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
            viewModel.transporter.getLogo()
                .resizable()
                .frame(height: 104)
                .scaledToFit()
                .cornerRadius(24)
                .padding(.vertical, 16)
            Text(viewModel.transporter.name)
                .font(.system(size: 24)).bold()
                .foregroundColor(.colorOnPrimary)
                .padding(.bottom, 16)
            Text("E-mail")
                .font(.system(size: 17))
                .foregroundColor(.colorOnPrimary)
            Text(viewModel.transporter.email)
                .font(.system(size: 12))
                .foregroundColor(.searchBackground)
                .padding(.bottom, 12)
                .onTapGesture {
                    openMail(emailTo: viewModel.transporter.email)
                }
            Text("Телефон")
                .font(.system(size: 17))
                .foregroundColor(.colorOnPrimary)
                .padding(.top, 12)
            Text(viewModel.transporter.phone)
                .font(.system(size: 12))
                .foregroundColor(.searchBackground)
                .padding(.bottom, 12)
                .onTapGesture {
                    let phoneNumber = viewModel.transporter.phone.filter("0123456789+".contains)
                    if let url = URL(string: "tel://\(phoneNumber)") {
                        openUrl(url)
                    }
                }
            Spacer()
        }.padding(.horizontal, 16)
            .navigationTitle("Информация о перевозчике ").navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .background(Color.colorPrimary.edgesIgnoringSafeArea(.all))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        searchData.currentlySelectedTextField = .nothing
                        self.path.removeLast()
                    }) {
                        Image( "NavBackButton")
                            .foregroundColor(Color.rzhdGreyBackButton)
                    }
                }
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
    TransporterView(path: .constant([]))
}
