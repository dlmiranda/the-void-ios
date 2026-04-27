//
//  RootTabView.swift
//  The Void
//
//  Purpose: Defines the main tab navigation across all four MVP screens.
//

import SwiftUI

struct RootTabView: View {
    private enum Tab: Hashable, CaseIterable {
        case compose
        case released
        case void
        case settings

        var title: String {
            switch self {
            case .compose: return "Compose"
            case .released: return "Released"
            case .void: return "Void"
            case .settings: return "Settings"
            }
        }

        var systemImage: String {
            switch self {
            case .compose: return "bubble.left.and.text.bubble.right"
            case .released: return "tray.full"
            case .void: return "sparkles"
            case .settings: return "gearshape"
            }
        }
    }

    @ObservedObject var mainViewModel: MainViewModel
    @State private var selectedTab: Tab = .compose

    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: $selectedTab) {
                ComposeView(mainViewModel: mainViewModel)
                    .tag(Tab.compose)

                ReleasedView(mainViewModel: mainViewModel)
                    .tag(Tab.released)

                VoidStatusView(mainViewModel: mainViewModel)
                    .tag(Tab.void)

                SettingsView(mainViewModel: mainViewModel)
                    .tag(Tab.settings)
            }
            .toolbar(.hidden, for: .tabBar)
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
        .safeAreaInset(edge: .bottom, spacing: 0) {
            customTabBar
        }
        .onChange(of: mainViewModel.lastPersistenceError) { _, newValue in
            guard newValue != nil else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                mainViewModel.clearPersistenceError()
            }
        }
    }

    private var customTabBar: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Button {
                    guard selectedTab != tab else { return }
                    var transaction = Transaction()
                    transaction.animation = nil
                    withTransaction(transaction) {
                        selectedTab = tab
                    }
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.systemImage)
                            .font(.system(size: 20, weight: .regular))
                        Text(tab.title)
                            .font(.caption2.weight(.medium))
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(selectedTab == tab ? AppTheme.accent : AppTheme.mutedText)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityAddTraits(selectedTab == tab ? [.isSelected] : [])
            }
        }
        .padding(.horizontal, 6)
        .padding(.top, 10)
        .padding(.bottom, 6)
        .background(AppTheme.background.ignoresSafeArea(edges: .bottom))
        .overlay(alignment: .top) {
            Rectangle()
                .fill(AppTheme.elevatedSurface)
                .frame(height: 1)
        }
    }
}

struct RootTabView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView(mainViewModel: MainViewModel())
    }
}
