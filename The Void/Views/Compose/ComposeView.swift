//
//  ComposeView.swift
//  The Void
//
//  Purpose: Placeholder compose screen for writing and sending thoughts.
//

import SwiftUI

struct ComposeView: View {
    @StateObject private var viewModel = ComposeViewModel()

    var body: some View {
        ScreenScaffold(
            title: "Compose",
            subtitle: "Type a thought and send it into The Void."
        ) {
            TextEditor(text: $viewModel.draftText)
                .scrollContentBackground(.hidden)
                .padding(12)
                .frame(minHeight: 180)
                .background(AppTheme.surface)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .foregroundStyle(AppTheme.primaryText)

            Picker("Delay", selection: $viewModel.selectedPreset) {
                ForEach(DelayPreset.allPresets) { preset in
                    Text(preset.title).tag(preset)
                }
            }
            .pickerStyle(.segmented)

            Button("Send to The Void") {
                // Intentionally empty in scaffold phase.
            }
            .buttonStyle(.borderedProminent)
            .tint(AppTheme.accent)
        }
    }
}

struct ComposeView_Previews: PreviewProvider {
    static var previews: some View {
        ComposeView()
    }
}
