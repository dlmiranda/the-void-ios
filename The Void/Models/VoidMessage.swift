//
//  VoidMessage.swift
//  The Void
//
//  Purpose: Defines the core message model that will be hidden until unlock time.
//

import Foundation

struct VoidMessage: Identifiable, Codable {
    let id: UUID
    let text: String
    let createdAt: Date
    let unlockAt: Date
    var isFavorite: Bool?

    init(
        id: UUID = UUID(),
        text: String,
        createdAt: Date = Date(),
        unlockAt: Date,
        isFavorite: Bool? = nil
    ) {
        self.id = id
        self.text = text
        self.createdAt = createdAt
        self.unlockAt = unlockAt
        self.isFavorite = isFavorite
    }

    var isReleased: Bool {
        Date() >= unlockAt
    }
}
