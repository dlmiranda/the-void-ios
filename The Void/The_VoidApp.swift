//
//  The_VoidApp.swift
//  The Void
//
//  Created by David Miranda on 4/15/26.
//

import SwiftUI

// Purpose: App entry point that launches the root tab interface.
@main
struct The_VoidApp: App {
    @StateObject private var messageStore = MessageStore()

    var body: some Scene {
        WindowGroup {
            RootTabView(messageStore: messageStore)
        }
    }
}
