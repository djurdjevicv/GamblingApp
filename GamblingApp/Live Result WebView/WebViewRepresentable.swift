//
//  WebViewRepresentable.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/18/24.
//

import Foundation
import UIKit
import SwiftUI
import WebKit

struct WebViewRepresentable: UIViewRepresentable {
    
    @Binding var url: URL
    typealias UIViewType = WKWebView

    var webView = WKWebView()
    
    func makeCoordinator() -> WebViewCoordinator {
        return WebViewCoordinator()
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        webView.backgroundColor = UIColor.charcoalBlack
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        webView.load(URLRequest(url: url))
    }
    
}

class WebViewCoordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
        .allow
    }
}
