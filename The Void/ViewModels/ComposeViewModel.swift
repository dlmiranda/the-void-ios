//
//  ComposeViewModel.swift
//  The Void
//
//  Purpose: Owns compose screen input state for the first draft UI.
//

import Foundation
import Combine

final class ComposeViewModel: ObservableObject {
    @Published var draftText: String = ""
    @Published var selectedPreset: DelayPreset = .defaultPreset
}
