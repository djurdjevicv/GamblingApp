//
//  NetworkingClient.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/18/24.
//

import Foundation

class NetworkingClient {
    
    static let shared = NetworkingClient()
    
    func getUpcomingGames(completion: @escaping (Result<[UpcomingGameDTO], NetworkError>) -> Void) {
        guard let url = Constants.API.upcomingGreekKenoGames else {
            completion(.failure(.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, response, error in
            let decoder = JSONDecoder()
            if let data, let upcomingGames = try? decoder.decode([UpcomingGameDTO].self, from: data) {
                completion(.success(upcomingGames))
            } else {
                completion(.failure(.decodeError))
            }
        }
        task.resume()
    }
    
    func getGreekKenoResults(completion: @escaping (Result<[GreekKenoDTO], NetworkError>) -> Void) {
        let currentDate = Date.getDateForResultsScreen()
        guard let url = Constants.API.greekKenoGamesResultByDate(from: currentDate, to: currentDate) else {
            completion(.failure(.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, response, error in
            let decoder = JSONDecoder()
            if let data, let results = try? decoder.decode(GreekKenoContent.self, from: data) {
                if let greekKenoResults = results.content {
                    completion(.success(greekKenoResults))
                }
            } else {
                completion(.failure(.decodeError))
            }
        }
        task.resume()
    }
    
    func getGameResultData(drawId: Int, completion: @escaping (Result<GreekKenoDTO, NetworkError>) -> Void) {
        guard let url = Constants.API.greekKenoById("\(drawId)") else {
            completion(.failure(.badURL))
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, response, error in
            let decoder = JSONDecoder()
            if let data, let result = try? decoder.decode(GreekKenoDTO.self, from: data) {
                completion(.success(result))
            } else {
                completion(.failure(.decodeError))
            }
        }
        task.resume()
    }
}
