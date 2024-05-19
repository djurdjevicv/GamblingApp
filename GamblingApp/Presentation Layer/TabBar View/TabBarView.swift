//
//  TabBarView.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/18/24.
//

import SwiftUI

struct TabBarView: View {
        
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.dirtyWhite
        UITabBar.appearance().barTintColor = UIColor.darkGray
        UITabBar.appearance().backgroundColor = UIColor.darkGray
    }
    
    var body: some View {
        TabView {
            RoundListView()
                .tabItem {
                    Label("Kola", systemImage: "7.circle")
                }
            LiveResultsWebView()
                .tabItem {
                    Label("Uzivo", systemImage: "livephoto")
                }
            ResultsView()
                .tabItem {
                    Label("Rezultati", systemImage: "r.circle")
                }
        }
        .accentColor(Color.mozzartYellow)
    }
}

#Preview {
    TabBarView()
}
