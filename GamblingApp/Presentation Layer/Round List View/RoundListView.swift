//
//  RoundListView.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/18/24.
//

import SwiftUI
import AlertToast

struct RoundListView: View {
    
    @State var upcomingGames = [UpcomingGameDTO]()
    @State var currentTimestamp = Date().timeIntervalSince1970
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var showFetchErrorToast = false
        
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
            .toast(isPresenting: $showFetchErrorToast) {
                AlertToast(displayMode: .banner(.pop), type: .regular, title: UserPreferredLanguage.userPreferredLanguage() == .english ? "Failed to fetch upcoming games." : "Preuzimanje predstojećih igara nije uspelo!")
            }
        }
        .onAppear {
            fetchUpcomingGames()
            timer = timer.upstream.autoconnect()
        }
        .onDisappear {
            timer.upstream.connect().cancel()
        }
        .onReceive(timer) { _ in
            currentTimestamp = Date().timeIntervalSince1970
            if let firstGame = upcomingGames.first {
                if Int(firstGame.drawTime / 1000) < Int(currentTimestamp) {
                    upcomingGames.removeFirst()
                    fetchUpcomingGames()
                }
            }
        }
    }
    
    private func fetchUpcomingGames() {
        NetworkingClient.shared.getUpcomingGames { result in
            switch result {
            case .success(let games):
                upcomingGames = games
            case .failure(let failure):
                switch failure {
                case .decodeError:
                    print("RoundListView: Error while fatching upcoming games - Decode error!")
                case .badURL:
                    print("RoundListView: Error while fatching upcoming games - Bad URL!")
                }
                showFetchErrorToast = true
            }
        }
    }
    
    private func buttonForChangingLanguages() -> some View {
        Button(action: {
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }, label: {
            Text(UserPreferredLanguage.userPreferredLanguage() == .english ? "🇬🇧" : "🇷🇸")
                .font(.system(size: 32))
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
                        .foregroundStyle(Date.getSecondsUntilGame(gameTimestamp: game.drawTime, currentTimestamp: currentTimeStamp) < 60 ? Color.errorRed : Color.dirtyWhite)
                }
                .font(Constants.CustomFont.ProximaNova.regular21)
            }
            .listRowBackground(Color.charcoalBlack)
            .listRowSeparatorTint(Color.lightGray)
            .padding([.top, .bottom], 10)
        }
        .listStyle(.plain)
        .foregroundStyle(Color.charcoalBlack)
        .background(Color.charcoalBlack)
    }
}

#Preview {
    RoundListView()
}
