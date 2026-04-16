//
//  ReleasedView.swift
//  The Void
//
//  Purpose: Placeholder released screen where unlocked messages will appear.
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
                Text("Nothing released yet.")
                    .font(.headline)
                    .foregroundStyle(AppTheme.secondaryText)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(AppTheme.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        ForEach(mainViewModel.releasedMessages) { message in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(message.text)
                                    .foregroundStyle(AppTheme.primaryText)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                Text("Released \(Self.timestampFormatter.string(from: message.unlockAt))")
                                    .font(.caption)
                                    .foregroundStyle(AppTheme.secondaryText)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(AppTheme.surface)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                    }
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
