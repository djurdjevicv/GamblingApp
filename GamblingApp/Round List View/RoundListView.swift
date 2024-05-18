//
//  HomeScreen.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/18/24.
//

import SwiftUI

struct RoundListView: View {
    
    @State var upcomingGames = [UpcomingGameDTO]()
    @State var currentTimestamp = Date().timeIntervalSince1970
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            VStack {
                headerView()
                listView(upcomingGames: upcomingGames, currentTimeStamp: currentTimestamp)
            }
            .background(Color.charcoalBlack)
        }
        .onAppear {
            NetworkingClient.shared.getUpcomingGames { games in
                upcomingGames = games
            }
        }
        .onDisappear {
            //timer.upstream.connect().cancel()
        }
        .onReceive(timer) { _ in
            currentTimestamp = Date().timeIntervalSince1970
            if let firstGame = upcomingGames.first {
                if Int(firstGame.drawTime / 1000) < Int(currentTimestamp) {
                    NetworkingClient.shared.getUpcomingGames { games in
                        upcomingGames = games
                    }
                }
            }
        }
    }
    
    func headerView() -> some View {
        VStack {
            HStack {
                Image("greece.flag")
                    .resizable()
                    .frame(width: 40, height: 40)
                Text("GRČKI KINO (20/80)")
                    .foregroundStyle(Color.dirtyWhite)
                Spacer()
            }
            
            Rectangle()
                .foregroundStyle(Color.darkBlue)
                .frame(maxWidth: .infinity, maxHeight: 1)
            
            HStack {
                Text("Vreme izvlačenja")
                    .foregroundStyle(Color.dirtyWhite)
                Spacer()
                Text("Preostalo za uplatu")
                    .foregroundStyle(Color.dirtyWhite)
            }
        }
        .padding([.top, .bottom], 8)
        .padding([.leading, .trailing], 8)
        .background(Color.lightGray)
        .padding(2)
    }
    
    func listView(upcomingGames: [UpcomingGameDTO], currentTimeStamp: TimeInterval) -> some View {
        List(upcomingGames) { game in
            NavigationLink(destination: GreekKinoView(upcomingGame: game)) {
                HStack {
                    Text(Date.getHourAndMinutesFromTimestamp(timestamp: game.drawTime))
                        .foregroundStyle(Color.dirtyWhite)
                    Spacer()
                                    
                    Text(Date.getTimeUntilNow(timestamp: game.drawTime, currentTimestamp: currentTimeStamp))
                        .foregroundStyle(Date.getSecondsUntilGame(gameTimestamp: game.drawTime, currentTimestamp: currentTimeStamp) < 10 ? Color("Red") : Color.dirtyWhite)
                }
            }
            .listRowBackground(Color.charcoalBlack)
            .listRowSeparatorTint(Color.lightGray)
            .padding([.top, .bottom], 10)
        }
        .listStyle(.plain)
        .background(Color.charcoalBlack)
    }
}

#Preview {
    RoundListView()
}
