//
//  WebView.swift
//  Rzhd
//
//  Created by Александр Поляков on 23.04.2024.
//  Inspired by https://sarunw.com/posts/swiftui-webview/

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    // 1
    let url: URL

    
    // 2
    func makeUIView(context: Context) -> WKWebView {

        return WKWebView()
    }
    
    // 3
    func updateUIView(_ webView: WKWebView, context: Context) {

        let request = URLRequest(url: url)
        webView.load(request)
    }
}

#Preview {
    WebView(url: URL(string: "https://www.rzhd.ru")!)
}
