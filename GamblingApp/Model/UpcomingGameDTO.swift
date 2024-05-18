//
//  UpcomingGameDTO.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/18/24.
//

import Foundation

struct UpcomingGameDTO: Codable, Hashable, Identifiable {
    var id: Int {
        return drawId
    }
    
    let gameId : Int
    let drawId : Int
    let drawTime : Int
    let status : String

    init(gameId: Int, drawId: Int, drawTime: Int, status: String) {
        self.gameId = gameId
        self.drawId = drawId
        self.drawTime = drawTime
        self.status = status
    }
}
