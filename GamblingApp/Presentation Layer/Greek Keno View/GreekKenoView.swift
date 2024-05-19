//
//  GreekKenoView.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/16/24.
//

import SwiftUI

struct GreekKenoView: View {
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 10)
    let upcomingGame: UpcomingGameDTO
    
    @State var kenoOdds = [KenoOdds(numberOfBall: 1, odds: 3.75),
                           KenoOdds(numberOfBall: 2, odds: 14),
                           KenoOdds(numberOfBall: 3, odds: 65),
                           KenoOdds(numberOfBall: 4, odds: 275),
                           KenoOdds(numberOfBall: 5, odds: 1350),
                           KenoOdds(numberOfBall: 6, odds: 6500),
                           KenoOdds(numberOfBall: 7, odds: 25000),
                           KenoOdds(numberOfBall: 8, odds: 125000)]
    
    @State var numberOfRandomBalls: Int = 8
    @State var currentTimestamp = Date.now.timeIntervalSince1970
    @State var selectedNumbers = Set<Int>()
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
    private let selectedRandomWinNumbers: Set<Int> = {
        var numbers = Set<Int>()
        while numbers.count < 20 {
            numbers.insert(Int.random(in: 1...80))
        }
        return numbers
    }()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    headerView()
                    oddsView()
                    getRandomNumbersView()
                    numbersGridView()
                }
            }
            .background(Color.charcoalBlack)
            .safeAreaInset(edge: .bottom, content: {
                if !selectedNumbers.isEmpty {
                    numberOfSelectedNumbersView()
                        .padding(.bottom)
                }
            })
        }
        .onReceive(timer) { _ in
            currentTimestamp = Date.now.timeIntervalSince1970
        }
        .onDisappear {
            timer.upstream.connect().cancel()
        }
    }
    
    private func getRandomNumbers() {
        var randomNumberGenerated =  Set<Int>()
        while randomNumberGenerated.count < numberOfRandomBalls {
            randomNumberGenerated.insert(Int.random(in: 1...80))
        }
        selectedNumbers.removeAll()
        selectedNumbers = randomNumberGenerated
    }
    
    private func headerView() -> some View {
        HStack {
            HStack(spacing: 0) {
                Text("Vreme izvlačenja: ")
                Text(" \(Date.getMonthAndDayFromTimestamp(timestamp: upcomingGame.drawTime))")
                Text(" \(Date.getHourAndMinutesFromTimestamp(timestamp: upcomingGame.drawTime))")
                Text(" | ")
                Text("Kolo:")
                Text(verbatim: " \(upcomingGame.drawId)")
            }
            .foregroundStyle(Color.dirtyWhite)
            .font(Constants.CustomFont.ProximaNova.regular14)
                        
            Spacer()
            
            if Date.getSecondsUntilGame(gameTimestamp: upcomingGame.drawTime, currentTimestamp: currentTimestamp) < 0 {
                NavigationLink {
                    OneRoundResult(drawId: upcomingGame.drawId)
                } label: {
                    Text("Rezultati")
                        .foregroundStyle(.dirtyWhite)
                        .font(Constants.CustomFont.ProximaNova.regular17)
                }
            } else {
                Text(Date.getTimeUntilNow(timestamp: upcomingGame.drawTime, currentTimestamp: currentTimestamp))
                    .foregroundStyle(Date.getSecondsUntilGame(gameTimestamp: upcomingGame.drawTime, currentTimestamp: currentTimestamp) < 60 ? Color.red : Color.white)
                    .font(Constants.CustomFont.ProximaNova.regular17)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .padding([.leading, .trailing], 12)
        .background(Color.darkGray)
    }
    
    private func oddsView() -> some View {
        HStack {
            VStack {
                Text("B.K.")
                    .foregroundColor(Color.lightGray)
                    .font(Constants.CustomFont.ProximaNova.regular17)
                Spacer()
                Text("Kvota")
                    .foregroundColor(Color.lightGray)
                    .font(Constants.CustomFont.ProximaNova.regular17)
            }
            .padding([.leading, .trailing], 10)
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(kenoOdds, id: \.self) { odd in
                        VStack {
                            Text("\(odd.numberOfBall)")
                                .foregroundColor(odd.numberOfBall == selectedNumbers.count ?  Color.dirtyWhite : Color.lightGray)
                                .font(Constants.CustomFont.ProximaNova.regular15)
                            Rectangle()
                                .fill(Color.lightGray)
                                .frame(height: 1)
                            Text("\(odd.odds.getOddFormat())")
                                .foregroundColor(Color.lightGray)
                                .frame(width: 60)
                                .font(Constants.CustomFont.ProximaNova.regular15)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
    
    private func getRandomNumbersView() -> some View {
        HStack {
            Button {
                getRandomNumbers()
            } label: {
                Text("Slučajni odabir")
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(Color.dirtyWhite)
                    .padding([.leading])
                    .font(Constants.CustomFont.ProximaNova.regular20)
            }
            
            Spacer()
            
            Text("Brojeva:")
                .foregroundStyle(Color.dirtyWhite)
                .font(Constants.CustomFont.ProximaNova.regular20)
            
            Picker("", selection: $numberOfRandomBalls) {
                ForEach(1..<16) {
                    Text("\($0)")
                        .tag($0)
                }
            }
        }
    }
    
    private func numbersGridView() -> some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(1..<81, id: \.self) { number in
                Button {
                    if selectedNumbers.contains(number) {
                        selectedNumbers.remove(number)
                    } else if selectedNumbers.count < 15 {
                        selectedNumbers.insert(number)
                    }
                } label: {
                    Text("\(number)")
                        .multilineTextAlignment(.center)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 44, maxHeight: 44)
                        .foregroundColor(Color.lightGray)
                        .background(Rectangle().strokeBorder(Color.darkGray, lineWidth: 1))
                        .font(Constants.CustomFont.ProximaNova.regular18)
                        .overlay(
                            selectedNumbers.contains(number) ? Circle()
                                .stroke(Color.checkNumberColor(number: number), lineWidth: 2)
                                .padding(6) : nil
                        )
                }
            }
        }
    }
    
    private func numberOfSelectedNumbersView() -> some View {
        HStack {
            Text("Moj broj")
                .foregroundStyle(.dirtyWhite)
                .padding([.leading, .trailing], 6)
            
            ZStack {
                Circle()
                    .fill(Color.mozzartYellow)
                    .frame(width: 35, height: 35)
                Text("\(selectedNumbers.count)")
                    .foregroundStyle(.charcoalBlack)
            }
            .clipShape(Circle())
            .padding()
        }
        .background(Color.darkGray)
        .border(.dirtyWhite)
    }
}

//#Preview {
//    GreekKenoView(upcomingGame: )
//}
