//
//  RootTabView.swift
//  The Void
//
//  Purpose: Defines the main tab navigation across all four MVP screens.
//

import SwiftUI

struct RootTabView: View {
    private enum Tab: Hashable {
        case compose
        case released
        case void
        case settings
    }

    @ObservedObject var mainViewModel: MainViewModel
    @State private var selectedTab: Tab = .compose

    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: $selectedTab) {
                ComposeView(mainViewModel: mainViewModel)
                    .tag(Tab.compose)
                    .tabItem {
                        Label("Compose", systemImage: "bubble.left.and.text.bubble.right")
                    }

                ReleasedView(mainViewModel: mainViewModel)
                    .tag(Tab.released)
                    .tabItem {
                        Label("Released", systemImage: "tray.full")
                    }

                VoidStatusView(mainViewModel: mainViewModel)
                    .tag(Tab.void)
                    .tabItem {
                        Label("Void", systemImage: "sparkles")
                    }

                SettingsView(mainViewModel: mainViewModel)
                    .tag(Tab.settings)
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
            }
            .tint(AppTheme.accent)
            .animation(nil, value: selectedTab)
            .transaction { transaction in
                transaction.animation = nil
            }

            if let errorMessage = mainViewModel.lastPersistenceError {
                Text(errorMessage)
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(AppTheme.primaryText)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(Color.red.opacity(0.9))
                    .clipShape(Capsule())
                    .padding(.top, 10)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .onChange(of: mainViewModel.lastPersistenceError) { _, newValue in
            guard newValue != nil else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                mainViewModel.clearPersistenceError()
            }
        }
    }
}

struct RootTabView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView(mainViewModel: MainViewModel())
    }
}
