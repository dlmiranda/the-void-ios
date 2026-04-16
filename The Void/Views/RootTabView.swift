//
//  RootTabView.swift
//  The Void
//
//  Purpose: Defines the main tab navigation across all four MVP screens.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            ComposeView()
                .tabItem {
                    Label("Compose", systemImage: "square.and.pencil")
                }

            ReleasedView()
                .tabItem {
                    Label("Released", systemImage: "tray.full")
                }

            VoidStatusView()
                .tabItem {
                    Label("Void", systemImage: "moon.stars")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .tint(AppTheme.accent)
    }
}

struct RootTabView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView()
    }
}
