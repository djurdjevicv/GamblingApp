//
//  ResultsView.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/18/24.
//

import SwiftUI

struct ResultsView: View {
    @State var greekKenoResults = [GreekKenoDTO]()
    
    var body: some View {
        NavigationStack {
            List(greekKenoResults) { gameResult in
                GameResultView(result: gameResult)
                    .listRowBackground(Color.charcoalBlack)
                    .listRowSeparator(.hidden)
                    .background(Color.charcoalBlack)
            }
            .padding(.top, 10)
            .navigationBarItems(leading: LogoNavBarView())
            .listStyle(.plain)
            .background(Color.charcoalBlack)
            .refreshable {
                fetchKenoResults()
            }
        }
        .background(Color.charcoalBlack)
        .onAppear {
            UIRefreshControl.appearance().tintColor = .lightGray
            UIRefreshControl.appearance().backgroundColor = .charcoalBlack
            fetchKenoResults()
        }
    }
    
    private func fetchKenoResults() {
        NetworkingClient.shared.getGreekKenoResults { results in
            greekKenoResults = results
        }
    }
}

#Preview {
    ResultsView()
}
