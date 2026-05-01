//
//  SettingsView.swift
//  The Void
//
//  Purpose: Minimal MVP settings with app info and clear-local-data action.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var mainViewModel: MainViewModel
    @State private var showClearConfirmation = false

    /// Snoball Productions site; `#privacy` scrolls to the policy section.
    private static let privacyPolicyURL = URL(string: "https://snoballproductions.com/home#privacy")!

    /// Snoball Productions site; `#support` scrolls to support / contact info.
    private static let supportURL = URL(string: "https://snoballproductions.com/home#support")!

    var body: some View {
        ScreenScaffold(
            title: "Settings",
            subtitle: "Minimal controls for this local-only MVP."
        ) {
            VStack(alignment: .leading, spacing: 10) {
                Text("The Void")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(AppTheme.primaryText)

                Text("Send a thought into The Void, and it stays hidden until the time you chose has passed.")
                    .font(.subheadline)
                    .foregroundStyle(AppTheme.secondaryText)

                Text("Version \(appVersionText)")
                    .font(.caption)
                    .foregroundStyle(AppTheme.secondaryText)
            }
            .padding()
            .background(AppTheme.surface)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(AppTheme.elevatedSurface, lineWidth: 1)
            )

            Link(destination: Self.privacyPolicyURL) {
                HStack {
                    Text("Privacy Policy")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(AppTheme.primaryText)
                    Spacer()
                    Image(systemName: "arrow.up.right.square")
                        .font(.body)
                        .foregroundStyle(AppTheme.secondaryText)
                }
                .padding()
                .background(AppTheme.surface)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(AppTheme.elevatedSurface, lineWidth: 1)
                )
            }
            .tint(AppTheme.accent)

            Link(destination: Self.supportURL) {
                HStack {
                    Text("Support")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(AppTheme.primaryText)
                    Spacer()
                    Image(systemName: "arrow.up.right.square")
                        .font(.body)
                        .foregroundStyle(AppTheme.secondaryText)
                }
                .padding()
                .background(AppTheme.surface)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(AppTheme.elevatedSurface, lineWidth: 1)
                )
            }
            .tint(AppTheme.accent)

            Button(role: .destructive) {
                showClearConfirmation = true
            } label: {
                Text("Clear All Local Data")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            .alert("Clear all local data?", isPresented: $showClearConfirmation) {
                Button("Cancel", role: .cancel) {}
                Button("Clear", role: .destructive) {
                    mainViewModel.clearAllMessages()
                }
            } message: {
                Text("This removes all stored messages from this device.")
            }
        }
    }

    private var appVersionText: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "\(version) (\(build))"
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(mainViewModel: MainViewModel())
    }
}
