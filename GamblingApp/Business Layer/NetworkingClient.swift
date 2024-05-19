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
        guard let url = Constants.API.upcomingGreekKenoGames else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, response, error in
            let decoder = JSONDecoder()
            if let data, let upcomingGames = try? decoder.decode([UpcomingGameDTO].self, from: data) {
                completion(upcomingGames)
            }
        }
        task.resume()
    }
    
    func getGreekKenoResults(completion: @escaping ([GreekKenoDTO]) -> Void) {
        let currentDate = Date.getDateForResultsScreen()
        guard let url = Constants.API.greekKenoGamesResultByDate(from: currentDate, to: currentDate) else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, response, error in
            let decoder = JSONDecoder()
            if let data, let results = try? decoder.decode(GreekKenoContent.self, from: data) {
                if let greekKenoResults = results.content {
                    completion(greekKenoResults)
                }
            }
        }
        task.resume()
    }
    
    func getGameResultData(drawId: Int, completion: @escaping (GreekKenoDTO) -> Void) {
        guard let url = Constants.API.greekKenoById("\(drawId)") else { return }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, response, error in
            let decoder = JSONDecoder()
            if let data, let result = try? decoder.decode(GreekKenoDTO.self, from: data) {
                completion(result)
            }
        }
        task.resume()
    }
}
