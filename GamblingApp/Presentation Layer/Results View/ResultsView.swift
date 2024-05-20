//
//  ResultsView.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/18/24.
//

import AlertToast
import SwiftUI

struct ResultsView: View {
    @State var greekKenoResults = [GreekKenoDTO]()
    @State private var showFetchErrorToast = false
    
    var body: some View {
        NavigationStack {
            List(greekKenoResults) { gameResult in
                GameResultView(result: gameResult)
                    .listRowBackground(Color.charcoalBlack)
                    .listRowSeparator(.hidden)
                    .background(Color.charcoalBlack)
            }
            .toast(isPresenting: $showFetchErrorToast) {
                AlertToast(displayMode: .banner(.pop), type: .regular, title: UserPreferredLanguage.userPreferredLanguage() == .english ? "Failed to fetch Greek Keno results!" : "Preuzimanje rezultata Grčkog kina nije uspelo!")
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
            switch results {
            case .success(let kenoResults):
                greekKenoResults = kenoResults
            case .failure(let failure):
                switch failure {
                case .decodeError:
                    print("ResultsView: Error while fatching keno results - Decode error!")
                case .badURL:
                    print("ResultsView: Error while fatching keno results - Bad URL!")
                }
                showFetchErrorToast = true
            }
        }
    }
}

#Preview {
    ResultsView()
}
