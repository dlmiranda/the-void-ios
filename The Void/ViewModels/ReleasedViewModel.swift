//
//  ReleasedViewModel.swift
//  The Void
//
//  Purpose: Supplies released-screen state for placeholder and upcoming data wiring.
//

import Foundation
import Combine

final class ReleasedViewModel: ObservableObject {
    @Published var releasedMessages: [VoidMessage] = []

    private let messageStore: MessageStore
    private var cancellables = Set<AnyCancellable>()

    init(messageStore: MessageStore) {
        self.messageStore = messageStore

        messageStore.$messages
            .sink { [weak self] _ in
                self?.refresh()
            }
            .store(in: &cancellables)

        refresh()
    }

    func refresh(now: Date = Date()) {
        releasedMessages = messageStore.messages.filter { $0.unlockAt <= now }
    }
}
