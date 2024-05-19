//
//  WebViewRepresentable.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/18/24.
//

import SwiftUI
import WebKit

struct WebViewRepresentable: UIViewRepresentable {
    
    @Binding var url: URL

    private var webView = WKWebView()
        
    func makeUIView(context: Context) -> WKWebView  {
        let wkwebView = WKWebView()
        let request = URLRequest(url: url)
        wkwebView.load(request)
        return wkwebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }

}
