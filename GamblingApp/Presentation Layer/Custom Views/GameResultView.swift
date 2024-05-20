//
//  GameResultView.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/19/24.
//

import SwiftUI

struct GameResultView: View {
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)
    @State var result: GreekKenoDTO
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Text("Vreme izvlačenja: ")
                Text(" \(Date.getMonthAndDayFromTimestamp(timestamp: result.drawTime))")
                Text(" \(Date.getHourAndMinutesFromTimestamp(timestamp: result.drawTime))")
                Text(" | ")
                Text("Kolo:")
                Text(verbatim: " \(result.drawId)")
            }
            .foregroundStyle(Color.dirtyWhite)
            .font(Constants.CustomFont.ProximaNova.regular14)
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.lightGray)

            LazyVGrid(columns: columns, spacing: 0) {
                if let winningNumbers = result.winningNumbers?.list {
                    ForEach(winningNumbers, id: \.self) { number in
                        Text("\(number)")
                            .multilineTextAlignment(.center)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                            .foregroundColor(Color.dirtyWhite)
                            .font(Constants.CustomFont.ProximaNova.regular18)
                            .overlay(
                                Circle()
                                    .stroke(Color.checkNumberColor(number: number), lineWidth: 2)
                                    .padding(6)
                            )
                    }
                }
            }
        }
    }
}

#Preview {
    GameResultView(result: 
                    GreekKenoDTO(gameId: 1100,
                                 drawId: 1089758,
                                 drawTime: 1716106800000,
                                 status: "results",
                                 winningNumbers:
                                    WinningNumbers(list: [61, 34, 8, 53, 20, 
                                                          58, 14, 9, 29, 71,
                                                          31, 52, 13, 80, 16,
                                                          63, 47, 32, 54, 10])
                                )
    )
}
