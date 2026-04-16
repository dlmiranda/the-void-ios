//
//  MessageStore.swift
//  The Void
//
//  Purpose: Tiny local JSON store for saving and loading void messages on device.
//

import Foundation
import Combine

final class MessageStore: ObservableObject {
    @Published private(set) var messages: [VoidMessage] = []

    private let fileURL: URL
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init(filename: String = "messages.json") {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        self.fileURL = (documentsDirectory ?? URL(fileURLWithPath: NSTemporaryDirectory()))
            .appendingPathComponent(filename)
        load()
    }

    func add(_ message: VoidMessage) {
        messages.insert(message, at: 0)
        save()
    }

    func clearAll() {
        messages = []
        save()
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? decoder.decode([VoidMessage].self, from: data) else {
            messages = []
            return
        }
        messages = decoded
    }

    private func save() {
        guard let data = try? encoder.encode(messages) else { return }
        try? data.write(to: fileURL, options: [.atomic])
    }
}
