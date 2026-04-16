//
//  RootTabView.swift
//  The Void
//
//  Purpose: Defines the main tab navigation across all four MVP screens.
//

import SwiftUI

struct RootTabView: View {
    @ObservedObject var mainViewModel: MainViewModel

    var body: some View {
        ZStack(alignment: .top) {
            TabView {
                ComposeView(mainViewModel: mainViewModel)
                    .tabItem {
                        Label("Compose", systemImage: "bubble.left.and.text.bubble.right")
                    }

                ReleasedView(mainViewModel: mainViewModel)
                    .tabItem {
                        Label("Released", systemImage: "tray.full")
                    }

                VoidStatusView(mainViewModel: mainViewModel)
                    .tabItem {
                        Label("Void", systemImage: "sparkles")
                    }

                SettingsView(mainViewModel: mainViewModel)
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
            }
            .tint(AppTheme.accent)

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
        .animation(.easeInOut(duration: 0.2), value: mainViewModel.lastPersistenceError)
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
