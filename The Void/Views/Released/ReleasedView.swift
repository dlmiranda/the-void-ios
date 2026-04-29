//
//  ReleasedView.swift
//  The Void
//
//  Purpose: Read-only timeline of messages whose unlock time has passed.
//

import SwiftUI

struct ReleasedView: View {
    @ObservedObject var mainViewModel: MainViewModel
    private static let timestampFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        ScreenScaffold(
            title: "Released",
            subtitle: "Thoughts appear here after their unlock time."
        ) {
            if mainViewModel.releasedMessages.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Nothing released yet.")
                        .font(.headline)
                        .foregroundStyle(AppTheme.primaryText)
                    Text("When time passes, your messages arrive here quietly.")
                        .font(.subheadline)
                        .foregroundStyle(AppTheme.secondaryText)
                }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(AppTheme.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(AppTheme.elevatedSurface, lineWidth: 1)
                    )
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        ForEach(mainViewModel.releasedMessages) { message in
                            VStack(alignment: .leading, spacing: 10) {
                                Text(message.text)
                                    .font(.body)
                                    .foregroundStyle(AppTheme.primaryText)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                Text(Self.timestampFormatter.string(from: message.unlockAt))
                                    .font(.caption)
                                    .foregroundStyle(AppTheme.mutedText)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(AppTheme.surface)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(AppTheme.elevatedSurface, lineWidth: 1)
                            )
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct ReleasedView_Previews: PreviewProvider {
    static var previews: some View {
        ReleasedView(mainViewModel: MainViewModel())
    }
}
