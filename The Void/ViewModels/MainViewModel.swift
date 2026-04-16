//
//  MainViewModel.swift
//  The Void
//
//  Purpose: Main app state for managing, filtering, and creating void messages.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject {
    @Published private(set) var messages: [VoidMessage] = []
    @Published private(set) var lockedMessages: [VoidMessage] = []
    @Published private(set) var releasedMessages: [VoidMessage] = []
    @Published private(set) var nextUnlockTime: Date?
    @Published private(set) var lockedCount: Int = 0

    private let messageStore: MessageStore
    private var cancellables = Set<AnyCancellable>()

    init(messageStore: MessageStore = MessageStore()) {
        self.messageStore = messageStore

        messageStore.$messages
            .sink { [weak self] incomingMessages in
                self?.updateDerivedState(from: incomingMessages)
            }
            .store(in: &cancellables)

        // Lightweight time refresh so locked items move to released as time passes.
        Timer.publish(every: 30, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.refreshTimeBasedState()
            }
            .store(in: &cancellables)

        updateDerivedState(from: messageStore.messages)
    }

    @discardableResult
    func addMessage(text: String, delayPreset: DelayPreset, now: Date = Date()) -> VoidMessage? {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return nil }

        let message = VoidMessage(
            text: trimmedText,
            createdAt: now,
            unlockAt: delayPreset.unlockDate(from: now)
        )
        messageStore.add(message)
        return message
    }

    func clearAllMessages() {
        messageStore.clearAll()
    }

    func refreshTimeBasedState(now: Date = Date()) {
        updateDerivedState(from: messages, now: now)
    }

    private func updateDerivedState(from allMessages: [VoidMessage], now: Date = Date()) {
        messages = allMessages.sorted(by: Self.messageSortAscending)

        lockedMessages = messages
            .filter { $0.unlockAt > now }
            .sorted(by: Self.messageSortAscending)

        releasedMessages = messages
            .filter { $0.unlockAt <= now }
            .sorted(by: Self.messageSortAscending)

        nextUnlockTime = lockedMessages.map(\.unlockAt).min()
        lockedCount = lockedMessages.count
    }

    private static func messageSortAscending(lhs: VoidMessage, rhs: VoidMessage) -> Bool {
        if lhs.unlockAt != rhs.unlockAt {
            return lhs.unlockAt < rhs.unlockAt
        }
        return lhs.createdAt < rhs.createdAt
    }
}
