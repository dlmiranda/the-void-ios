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

    var isReleased: Bool {
        Date() >= unlockAt
    }
}
