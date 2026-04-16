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

    @discardableResult
    func add(_ message: VoidMessage) -> Bool {
        messages.insert(message, at: 0)
        return save()
    }

    @discardableResult
    func clearAll() -> Bool {
        messages = []
        return save()
    }

    @discardableResult
    func toggleFavorite(messageID: UUID) -> Bool {
        guard let index = messages.firstIndex(where: { $0.id == messageID }) else {
            return false
        }

        let original = messages[index]
        let current = original.isFavorite ?? false
        messages[index].isFavorite = !current

        if save() {
            return true
        }

        messages[index] = original
        return false
    }

    private func load() {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            messages = []
            return
        }

        do {
            let data = try Data(contentsOf: fileURL)
            messages = try decoder.decode([VoidMessage].self, from: data)
        } catch {
            // Keep startup resilient but log failures for debugging data issues.
            print("MessageStore load failed: \(error.localizedDescription)")
            messages = []
        }
    }

    @discardableResult
    private func save() -> Bool {
        do {
            let data = try encoder.encode(messages)
            try data.write(to: fileURL, options: [.atomic])
            return true
        } catch {
            print("MessageStore save failed: \(error.localizedDescription)")
            return false
        }
    }
}
