//
//  GreekKenoDTO.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/18/24.
//

import Foundation

struct GreekKenoDTO: Codable, Hashable, Identifiable {
    
    var id: Int {
        return drawId
    }
    
    let gameId : Int
    let drawId : Int
    let drawTime : Int
    let status : String
    let winningNumbers : WinningNumbers?
    
    init(gameId: Int, drawId: Int, drawTime: Int, status: String, winningNumbers: WinningNumbers?) {
        self.gameId = gameId
        self.drawId = drawId
        self.drawTime = drawTime
        self.status = status
        self.winningNumbers = winningNumbers
    }
}
