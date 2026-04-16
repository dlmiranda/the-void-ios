//
//  DelayPreset.swift
//  The Void
//
//  Purpose: Provides a simple set of delay options for message unlock timing.
//

import Foundation

enum DelayPreset: String, CaseIterable, Identifiable, Codable {
    case oneHour
    case tonight
    case tomorrow
    case threeDays
    case oneWeek

    var id: String { rawValue }

    var title: String {
        switch self {
        case .oneHour:
            return "1 Hour"
        case .tonight:
            return "Tonight"
        case .tomorrow:
            return "Tomorrow"
        case .threeDays:
            return "3 Days"
        case .oneWeek:
            return "1 Week"
        }
    }

    static var allPresets: [DelayPreset] {
        [.oneHour, .tonight, .tomorrow, .threeDays, .oneWeek]
    }

    static var defaultPreset: DelayPreset {
        .oneHour
    }

    func unlockDate(from date: Date = Date(), calendar: Calendar = .current) -> Date {
        switch self {
        case .oneHour:
            return date.addingTimeInterval(60 * 60)
        case .threeDays:
            return date.addingTimeInterval(3 * 24 * 60 * 60)
        case .oneWeek:
            return date.addingTimeInterval(7 * 24 * 60 * 60)
        case .tonight:
            return tonightUnlockDate(from: date, calendar: calendar)
        case .tomorrow:
            return tomorrowUnlockDate(from: date, calendar: calendar)
        }
    }

    private func tonightUnlockDate(from date: Date, calendar: Calendar) -> Date {
        let ninePMToday = calendar.date(
            bySettingHour: 21,
            minute: 0,
            second: 0,
            of: date
        ) ?? date

        if ninePMToday > date {
            return ninePMToday
        }

        return calendar.date(byAdding: .day, value: 1, to: ninePMToday) ?? date
    }

    private func tomorrowUnlockDate(from date: Date, calendar: Calendar) -> Date {
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: date) ?? date
        return calendar.startOfDay(for: tomorrow)
    }
}
