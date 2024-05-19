//
//  LiveResultsWebView.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/18/24.
//

import SwiftUI

struct LiveResultsWebView: View {
    
    @State private var url = Constants.API.liveGreekKenoResults()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let liveKenoUrl = Binding($url) {
                    WebViewRepresentable(url: liveKenoUrl)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.charcoalBlack)
                        .padding(.top, 10)
                }
            }
            .navigationBarItems(leading: LogoNavBarView())
            .background(Color.charcoalBlack)
        }
        .background(Color.charcoalBlack)
    }
}

#Preview {
    LiveResultsWebView()
}
