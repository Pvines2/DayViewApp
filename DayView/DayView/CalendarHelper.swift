//
//  CalendarHelper.swift
//  DayView
//
//  Created by Parker Vines on 11/29/24.
//


import Foundation

struct CalendarHelper {
    static let calendar = Calendar.current

    // Get the first day of the current month
    static func firstDayOfMonth(for date: Date = Date()) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }

    // Get the number of days in the current month
    static func daysInMonth(for date: Date = Date()) -> Int {
        return calendar.range(of: .day, in: .month, for: date)!.count
    }

    // Get the weekday of the first day of the month (1 = Sunday, 7 = Saturday)
    static func weekdayOfFirstDay(for date: Date = Date()) -> Int {
        let firstDay = firstDayOfMonth(for: date)
        return calendar.component(.weekday, from: firstDay)
    }

    // Get the month name
    static func monthName(for date: Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: date)
    }

    // Get the year
    static func year(for date: Date = Date()) -> Int {
        return calendar.component(.year, from: date)
    }

    // Get the days of the week
    static func weekdayNames() -> [String] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        return formatter.shortWeekdaySymbols
    }
}
