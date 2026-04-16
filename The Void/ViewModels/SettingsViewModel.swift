//
//  SettingsViewModel.swift
//  The Void
//
//  Purpose: Stores minimal settings-screen state for MVP scaffolding.
//

import Foundation
import Combine

final class SettingsViewModel: ObservableObject {
    @Published var selectedDefaultPreset: DelayPreset = .defaultPreset
}
