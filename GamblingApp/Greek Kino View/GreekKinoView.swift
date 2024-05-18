//
//  GreekKinoView.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/16/24.
//

import SwiftUI

struct GreekKinoView: View {
    let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 10)
    let upcomingGame: UpcomingGameDTO
    
    @State var kinoOdds = [KinoOdds(numberOfBall: 1, odds: 3.75),
                           KinoOdds(numberOfBall: 2, odds: 14),
                           KinoOdds(numberOfBall: 3, odds: 65),
                           KinoOdds(numberOfBall: 4, odds: 275),
                           KinoOdds(numberOfBall: 5, odds: 1350),
                           KinoOdds(numberOfBall: 6, odds: 6500),
                           KinoOdds(numberOfBall: 7, odds: 25000),
                           KinoOdds(numberOfBall: 8, odds: 125000)]
    
    @State var numberOfRandomBalls: Int = 8
    @State var currentTimestamp = Date.now.timeIntervalSince1970
    @State var selectedNumbers = Set<Int>()
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var shouldShowResults = false
        
    let selectedRandomWinNumbers: Set<Int> = {
        var numbers = Set<Int>()
        while numbers.count < 20 {
            numbers.insert(Int.random(in: 1...80))
        }
        return numbers
    }()
    
    var body: some View {
        VStack {
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
            if Int(Date.now.timeIntervalSince1970) == upcomingGame.drawTime / 1000 {
                shouldShowResults = true
            }
            currentTimestamp = Date.now.timeIntervalSince1970
        }
        .onDisappear {
            timer.upstream.connect().cancel()
        }
    }
    
    func numberOfSelectedNumbersView() -> some View {
        HStack {
            Text("Moj broj")
                .foregroundStyle(.dirtyWhite)
                .padding([.leading, .trailing], 6)
            
            ZStack {
                Circle()
                    .fill(Color.mozzartYellow)
                    .background(Color.charcoalBlack)
                    .frame(width: 35, height: 35)
                Text("\(selectedNumbers.count)")
                    .foregroundStyle(.charcoalBlack)
            }
            .padding()
        }
        .background(Color.darkGray)
        .border(.gray)
    }
    
    func getRandomNumbers() {
        var randomNumberGenerated =  Set<Int>()
        while randomNumberGenerated.count < numberOfRandomBalls {
            randomNumberGenerated.insert(Int.random(in: 1...80))
        }
        selectedNumbers.removeAll()
        selectedNumbers = randomNumberGenerated
    }
    
    func headerView() -> some View {
        HStack {
            Text(verbatim: "Vreme izvlacenja \(Date.getHourAndMinutesFromTimestamp(timestamp: upcomingGame.drawTime)) | Kolo \(upcomingGame.drawId)")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color.dirtyWhite)
                .font(.system(size: 15))
            
            Spacer()
            
            Text(Date.getTimeUntilNow(timestamp: upcomingGame.drawTime, currentTimestamp: currentTimestamp))
                .foregroundStyle(Date.getSecondsUntilGame(gameTimestamp: upcomingGame.drawTime, currentTimestamp: currentTimestamp) < 60 ? Color.red : Color.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .padding([.leading, .trailing], 12)
        .background(Color.darkGray)
    }
    
    func oddsView() -> some View {
        HStack {
            VStack {
                Text("B.K.")
                    .foregroundColor(Color.lightGray)
                Spacer()
                Text("Kvota")
                    .foregroundColor(Color.lightGray)
            }
            .padding([.leading, .trailing], 10)
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(kinoOdds, id: \.self) { odd in
                        VStack {
                            Text("\(odd.numberOfBall)")
                                .foregroundColor(odd.numberOfBall == selectedNumbers.count ?  Color.dirtyWhite : Color.lightGray)
                            Rectangle()
                                .fill(Color.lightGray)
                                .frame(height: 1)
                            Text("\(odd.odds.getOddFormat())")
                                .foregroundColor(Color.lightGray)
                                .frame(width: 60)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
    
    func getRandomNumbersView() -> some View {
        HStack {
            Button {
                getRandomNumbers()
            } label: {
                Text("Slucajni odabir")
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(Color.dirtyWhite)
                    .padding([.leading])
            }
            
            Spacer()
            
            Text("Brojeva:")
                .foregroundStyle(Color.dirtyWhite)
            
            Picker("", selection: $numberOfRandomBalls) {
                ForEach(1..<16) {
                    Text("\($0)")
                        .tag($0)
                }
            }
        }
    }
    
    func numbersGridView() -> some View {
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
                        .overlay(
                            selectedNumbers.contains(number) ? Circle()
                                .stroke(Color.checkNumberColor(number: number), lineWidth: 2)
                                .padding(6) : nil
                        )
                }
            }
        }
    }
}

#Preview {
    GreekKinoView(upcomingGame: UpcomingGameDTO(gameId: 1, drawId: 1, drawTime: 1, status: "active"))
}
