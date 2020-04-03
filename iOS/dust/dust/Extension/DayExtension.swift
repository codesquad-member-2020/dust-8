//
//  DayExtension.swift
//  dust
//
//  Created by 신한섭 on 2020/04/03.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let dateConverter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}

extension Calendar {
    static let calculateDay: Calendar = {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }()
    
    func getHourMinuteString(date: Date) -> String {
        let components = self.dateComponents([.hour, .minute, .second], from: date)
        let day = self.isDateInToday(date) ? "오늘" : "어제"
        let time = day + " " + String(format: "%02d", components.hour ?? 0) + " : " + String(format: "%02d", components.minute ?? 0)
        return time
    }
}
