//
//  OneRoundResult.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/19/24.
//

import SwiftUI

struct OneRoundResult: View {
    
    let drawId: Int
    @State var result: GreekKenoDTO? = nil
    
    var body: some View {
        List {
            ZStack {
                if let result {
                    GameResultView(result: result)
                        .background(Color.charcoalBlack)
                }
            }
            .listRowBackground(Color.charcoalBlack)
            .listRowSeparator(.hidden)
            .padding([.top, .bottom], 10)
        }
        .listStyle(.plain)
        .background(Color.charcoalBlack)
        .refreshable {
            fetchGameResultData()
        }
        .onAppear {
            UIRefreshControl.appearance().tintColor = .lightGray
            UIRefreshControl.appearance().backgroundColor = .charcoalBlack
            fetchGameResultData()
        }
    }
    
    private func fetchGameResultData() {
        NetworkingClient.shared.getGameResultData(drawId: 1089785) { gameResult in
            result = gameResult
        }
    }
}

#Preview {
    OneRoundResult(drawId: 1)
}
