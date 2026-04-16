//
//  DelayPreset.swift
//  The Void
//
//  Purpose: Provides a simple set of delay options for message unlock timing.
//

import Foundation

struct DelayPreset: Identifiable, Hashable {
    let id: String
    let title: String
    let timeInterval: TimeInterval

    static let allPresets: [DelayPreset] = [
        DelayPreset(id: "ten-minutes", title: "10 Minutes", timeInterval: 10 * 60),
        DelayPreset(id: "one-hour", title: "1 Hour", timeInterval: 60 * 60),
        DelayPreset(id: "one-day", title: "1 Day", timeInterval: 24 * 60 * 60)
    ]

    static let defaultPreset: DelayPreset = allPresets[1]
}
