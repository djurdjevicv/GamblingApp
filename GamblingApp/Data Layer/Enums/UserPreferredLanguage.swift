//
//  UserPreferredLanguage.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/20/24.
//

import Foundation

enum UserPreferredLanguage: String {
    case english = "en-US"
    case serbian = "sr-Latn-US"
    case other
    
    static func userPreferredLanguage() -> UserPreferredLanguage {
        switch Locale.preferredLanguages.first {
        case english.rawValue:
            return english
        case serbian.rawValue:
            return serbian
        default:
            return other
        }
    }
}
