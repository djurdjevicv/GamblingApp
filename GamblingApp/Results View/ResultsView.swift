//
//  ResultsView.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/18/24.
//

import SwiftUI

struct ResultsView: View {
    let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)
    @State var greeceKinoResults = [GreeceKinoDTO]()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(greeceKinoResults, id: \.self) { gameResult in
                    results(result: gameResult)
                }
            }
        }
        .background(Color.charcoalBlack)
        .onAppear {
            NetworkingClient.shared.getGreeceKinoResults { results in
                greeceKinoResults = results
            }
        }
    }
    
    func results(result: GreeceKinoDTO) -> some View {
        VStack {
            Text(verbatim: "Vreme izvlačenja: \(Date.getMonthAndDayFromTimestamp(timestamp: result.drawTime))  \(Date.getHourAndMinutesFromTimestamp(timestamp: result.drawTime)) | Kolo: \(result.drawId)")
                .padding(10)
                .background(Color.lightGray)
                .foregroundStyle(Color.dirtyWhite)
            
            LazyVGrid(columns: columns, spacing: 0) {
                                
                ForEach(result.winningNumbers.list, id: \.self) { number in
                    Text("\(number)")
                        .multilineTextAlignment(.center)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                        .foregroundColor(Color.dirtyWhite)
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

#Preview {
    ResultsView()
}
