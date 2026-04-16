//
//  ComposeView.swift
//  The Void
//
//  Purpose: Placeholder compose screen for writing and sending thoughts.
//

import SwiftUI

struct ComposeView: View {
    @ObservedObject var mainViewModel: MainViewModel
    @State private var draftText: String = ""
    @State private var selectedPreset: DelayPreset = .defaultPreset
    @State private var showSentConfirmation = false

    private var canSend: Bool {
        !draftText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        ScreenScaffold(
            title: "Compose",
            subtitle: "Write it once, send it, and let it go."
        ) {
            ZStack(alignment: .topLeading) {
                TextEditor(text: $draftText)
                    .scrollContentBackground(.hidden)
                    .padding(12)
                    .frame(minHeight: 260, maxHeight: 320)
                    .background(AppTheme.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .foregroundStyle(AppTheme.primaryText)

                if draftText.isEmpty {
                    Text("Type your thought...")
                        .foregroundStyle(AppTheme.secondaryText)
                        .font(.body)
                        .padding(.top, 22)
                        .padding(.leading, 18)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(AppTheme.elevatedSurface, lineWidth: 1)
            )

            VStack(alignment: .leading, spacing: 10) {
                Text("Unlock After")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(AppTheme.secondaryText)

                Picker("Delay", selection: $selectedPreset) {
                    ForEach(DelayPreset.composePresets) { preset in
                        Text(preset.title)
                            .tag(preset)
                    }
                }
                .pickerStyle(.segmented)
                .colorScheme(.dark)
            }
            .padding(14)
            .background(AppTheme.surface)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(AppTheme.elevatedSurface, lineWidth: 1)
            )

            HStack(spacing: 12) {
                if showSentConfirmation {
                    Text("Sent to The Void")
                        .font(.footnote)
                        .foregroundStyle(AppTheme.secondaryText)
                        .transition(.opacity)
                }

                Spacer()

                Button("Send") {
                    let created = mainViewModel.addMessage(
                        text: draftText,
                        delayPreset: selectedPreset
                    )
                    if created != nil {
                        draftText = ""
                        withAnimation(.easeInOut(duration: 0.2)) {
                            showSentConfirmation = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                showSentConfirmation = false
                            }
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(AppTheme.accent)
                .disabled(!canSend)
                .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct ComposeView_Previews: PreviewProvider {
    static var previews: some View {
        ComposeView(mainViewModel: MainViewModel())
    }
}
