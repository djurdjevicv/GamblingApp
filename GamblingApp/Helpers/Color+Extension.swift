//
//  Color+Extension.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/18/24.
//

import SwiftUI

extension Color {
    static func checkNumberColor(number: Int) -> Color {
        switch number {
        case 1...10:
            return Color.yellow
        case 11...20:
            return Color.orange
        case 21...30:
            return Color.red
        case 31...40:
            return Color.pink
        case 41...50:
            return Color.purple
        case 51...60:
            return Color.cyan
        case 61...70:
            return Color.green
        case 71...80:
            return Color.blue
        default:
            return Color.white
        }
    }
}
