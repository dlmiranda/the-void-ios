//
//  SettingsView.swift
//  The Void
//
//  Purpose: Placeholder settings screen for default delay and app preferences.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()

    var body: some View {
        ScreenScaffold(
            title: "Settings",
            subtitle: "Keep preferences simple for MVP."
        ) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Default Delay")
                    .font(.headline)
                    .foregroundStyle(AppTheme.primaryText)

                Picker("Default Delay", selection: $viewModel.selectedDefaultPreset) {
                    ForEach(DelayPreset.allPresets) { preset in
                        Text(preset.title)
                            .tag(preset)
                    }
                }
                .pickerStyle(.menu)
                .tint(AppTheme.secondaryText)
                .colorScheme(.dark)
            }
            .padding()
            .background(AppTheme.surface)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
