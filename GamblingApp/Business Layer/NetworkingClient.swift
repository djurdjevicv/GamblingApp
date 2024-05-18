//
//  NetworkingClient.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/18/24.
//

import Foundation

class NetworkingClient {
    
    static let shared = NetworkingClient()
    
    func getUpcomingGames(completion: @escaping ([UpcomingGameDTO]) -> Void) {
        guard let url = URL(string: "https://api.opap.gr/draws/v3.0/1100/upcoming/20") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, response, error in
            let decoder = JSONDecoder()
            if let data, let upcomingGames = try? decoder.decode([UpcomingGameDTO].self, from: data) {
                completion(upcomingGames)
            }
        }
        task.resume()
    }
    
    func getGreeceKinoResults(completion: @escaping ([GreeceKinoDTO]) -> Void) {
        let currentDate = Date.getDateForResultsScreen()
        guard let url = URL(string: "https://api.opap.gr/draws/v3.0/1100/draw-date/\(currentDate)/\(currentDate)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, response, error in
            let decoder = JSONDecoder()
            if let data, let results = try? decoder.decode(GreeceKinoContent.self, from: data) {
                if let greeceKinoResults = results.content {
                    completion(greeceKinoResults)
                }
            }
        }
        task.resume()
    }
}
