//
//  Date+Extension.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/17/24.
//

import Foundation

extension Date {
    static func getHourAndMinutesFromTimestamp(timestamp: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(timestamp / 1000))
        let hour = Calendar.current.component(.hour, from: date as Date)
        let minute = Calendar.current.component(.minute, from: date as Date)
        
        let hoursFormatted = hour < 10 ? "0\(hour)" : "\(hour)"
        let minuteFormatted = minute < 10 ? "0\(minute)" : "\(minute)"
        
        return "\(hoursFormatted):\(minuteFormatted)"
    }
    
    static func getMonthAndDayFromTimestamp(timestamp: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(timestamp / 1000))
        let month = Calendar.current.component(.month, from: date as Date)
        let day = Calendar.current.component(.day, from: date as Date)
        
        let monthFormatted = month < 10 ? "0\(month)" : "\(month)"
        let dayFormatted = day < 10 ? "0\(day)" : "\(day)"
        
        return "\(dayFormatted).\(monthFormatted)"
    }
        
    static func getTimeUntilNow(timestamp: Int, currentTimestamp: TimeInterval) -> String {
        let secondsDifference = getSecondsUntilGame(gameTimestamp: timestamp, currentTimestamp: currentTimestamp)
        
        let hours = secondsDifference / 3600
        let minutes = (secondsDifference % 3600) / 60
        let seconds = secondsDifference % 60
        
        let hoursFormatted = hours < 10 ? "0\(hours)" : "\(hours)"
        let minutesFormatted = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        let secondsFormatted = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        
        if hours > 0 {
            return "\(hoursFormatted):\(minutesFormatted):\(secondsFormatted)"
        } else {
            return "\(minutesFormatted):\(secondsFormatted)"
        }
    }
    
    static func getSecondsUntilGame(gameTimestamp: Int, currentTimestamp: TimeInterval) -> Int {
        return Int((TimeInterval(gameTimestamp / 1000) - currentTimestamp))
    }
    
    static func getDateForResultsScreen() -> String {
        let year = Calendar.current.component(.year, from: Date())
        let month = Calendar.current.component(.month, from: Date())
        let day = Calendar.current.component(.day, from: Date())
        
        let monthFormatted = month < 10 ? "0\(month)" : "\(month)"
        let dayFormatted = day < 10 ? "0\(day)" : "\(day)"
        
        return "\(year)-\(monthFormatted)-\(dayFormatted)"
    }
}
