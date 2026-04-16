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

    private let messageStore: MessageStore

    init(messageStore: MessageStore) {
        self.messageStore = messageStore
    }

    var canSend: Bool {
        !draftText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    @discardableResult
    func send(now: Date = Date()) -> VoidMessage? {
        let trimmedText = draftText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return nil }

        let message = VoidMessage(
            text: trimmedText,
            createdAt: now,
            unlockAt: selectedPreset.unlockDate(from: now)
        )

        messageStore.add(message)
        draftText = ""
        return message
    }
}
