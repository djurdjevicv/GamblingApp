//
//  OneRoundResult.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/19/24.
//

import SwiftUI
import AlertToast

struct OneRoundResult: View {
    
    let drawId: Int
    @State var kenoResult: GreekKenoDTO? = nil
    @State private var showFetchErrorToast = false
    
    var body: some View {
        List {
            if let kenoResult {
                ForEach([kenoResult], id: \.self) { result in
                    GameResultView(result: kenoResult)
                        .background(Color.charcoalBlack)
                        .listRowBackground(Color.charcoalBlack)
                        .listRowSeparator(.hidden)
                        .padding([.top, .bottom], 10)
                }
            }
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
        NetworkingClient.shared.getGameResultData(drawId: drawId) { result in
            switch result {
            case .success(let gameResult):
                kenoResult = gameResult
            case .failure(let failure):
                switch failure {
                case .decodeError:
                    print("OneRoundResult: Error while fatching game result - Decode error!")
                case .badURL:
                    print("OneRoundResult: Error while fatching game result - Bad URL!")
                }
                showFetchErrorToast = true
            }
        }
    }
}

#Preview {
    OneRoundResult(drawId: 1090083)
}
