//
//  LiveResultsWebView.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/18/24.
//

import SwiftUI

struct LiveResultsWebView: View {
    
    @State private var url = URL(string: "https://mozzartbet.com/sr/lotto-animation/26#")!
    
    var body: some View {
        WebViewRepresentable(url: $url)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.charcoalBlack)
    }
}

#Preview {
    LiveResultsWebView()
}
