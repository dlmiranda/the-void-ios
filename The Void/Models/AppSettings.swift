//
//  AppSettings.swift
//  The Void
//
//  Purpose: Holds lightweight local preferences for app behavior.
//

import Foundation

struct AppSettings: Codable {
    var defaultPresetID: String = DelayPreset.defaultPreset.id
}
