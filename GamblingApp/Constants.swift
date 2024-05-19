//
//  Constants.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/19/24.
//

import Foundation
import SwiftUI

struct Constants {
    struct API {
        static let greekKenoBaseURL = "https://api.opap.gr/draws/v3.0/1100"
        
        static var upcomingGreekKenoGames: URL? {
            return URL(string: "\(greekKenoBaseURL)/upcoming/20")
        }
        
        static func greekKenoGamesResultByDate(from fromDate: String, to toDate: String) -> URL? {
            return URL(string: "\(greekKenoBaseURL)/draw-date/\(fromDate)/\(toDate)")
        }
        
        static func greekKenoById(_ drawId: String) -> URL? {
            return URL(string: "\(greekKenoBaseURL)/\(drawId)")
        }
        
        static func liveGreekKenoResults() -> URL? {
            return URL(string: "https://mozzartbet.com/sr/lotto-animation/26#")
        }
    }
    
    struct CustomFont {
        struct ProximaNova {
            static let regular21 = Font.custom("ProximaNova-Regular", size: 21)
            static let regular20 = Font.custom("ProximaNova-Regular", size: 20)
            static let regular18 = Font.custom("ProximaNova-Regular", size: 18)
            static let regular17 = Font.custom("ProximaNova-Regular", size: 17)
            static let regular15 = Font.custom("ProximaNova-Regular", size: 15)
            static let regular14 = Font.custom("ProximaNova-Regular", size: 14)
        }
        
        struct Linotte {
            static let heavy32 = Font.custom("Linotte-Heavy", size: 32)
        }
    }
}
