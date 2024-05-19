//
//  RoundListView.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/18/24.
//

import SwiftUI

struct RoundListView: View {
    
    @State var upcomingGames = [UpcomingGameDTO]()
    @State var currentTimestamp = Date().timeIntervalSince1970
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var userPreferredLanguage: String {
      return Locale.preferredLanguages.first ?? "Language preference not found"
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                headerView()
                listView(upcomingGames: upcomingGames, currentTimeStamp: currentTimestamp)
            }
            .background(Color.charcoalBlack)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    LogoNavBarView()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    buttonForChangingLanguages()
                }
            })
        }
        .onAppear {
            NetworkingClient.shared.getUpcomingGames { games in
                upcomingGames = games
            }
            timer = timer.upstream.autoconnect()
        }
        .onDisappear {
            timer.upstream.connect().cancel()
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
    
    private func buttonForChangingLanguages() -> some View {
        Button(action: {
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }, label: {
            if userPreferredLanguage == "sr-Latn-US" {
                Text("🇷🇸")
                    .font(.system(size: 32))
            } else if userPreferredLanguage == "en-US" {
                Text("🇬🇧")
                    .font(.system(size: 32))
            }
        })
    }
        
    private func headerView() -> some View {
        VStack {
            HStack {
                Image(ImageResource.greeceFlag)
                    .resizable()
                    .frame(width: 40, height: 40)
                Text("GRČKI KINO (20/80)")
                    .foregroundStyle(Color.dirtyWhite)
                    .font(Constants.CustomFont.ProximaNova.regular21)
                Spacer()
            }
            
            Rectangle()
                .foregroundStyle(Color.darkBlue)
                .frame(maxWidth: .infinity, maxHeight: 1)
            
            HStack {
                Text("Vreme izvlačenja")
                Spacer()
                Text("Preostalo za uplatu")
            }
            .foregroundStyle(Color.dirtyWhite)
            .font(Constants.CustomFont.ProximaNova.regular18)
        }
        .padding(8)
        .background(Color.lightGray)
        .padding(2)
    }
    
    private func listView(upcomingGames: [UpcomingGameDTO], currentTimeStamp: TimeInterval) -> some View {
        List(upcomingGames) { game in
            NavigationLink(destination: GreekKenoView(upcomingGame: game)) {
                HStack {
                    Text(Date.getHourAndMinutesFromTimestamp(timestamp: game.drawTime))
                        .foregroundStyle(Color.dirtyWhite)
                    
                    Spacer()
                                    
                    Text(Date.getTimeUntilNow(timestamp: game.drawTime, currentTimestamp: currentTimeStamp))
                        .foregroundStyle(Date.getSecondsUntilGame(gameTimestamp: game.drawTime, currentTimestamp: currentTimeStamp) < 10 ? Color.errorRed : Color.dirtyWhite)
                }
                .font(Constants.CustomFont.ProximaNova.regular21)
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
