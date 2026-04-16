//
//  VoidStatusView.swift
//  The Void
//
//  Purpose: Metadata-only view of locked messages without revealing content.
//

import SwiftUI

struct VoidStatusView: View {
    @ObservedObject var mainViewModel: MainViewModel

    var body: some View {
        TimelineView(.periodic(from: .now, by: 60)) { context in
            ScreenScaffold(
                title: "Void",
                subtitle: "You can see what is waiting, not what was said."
            ) {
                HStack(spacing: 12) {
                    StatusCard(title: "Locked", value: "\(mainViewModel.lockedCount)")
                    StatusCard(
                        title: "Next Unlock",
                        value: mainViewModel.nextUnlockTime.map(Self.timeFormatter.string(from:)) ?? "None"
                    )
                }

                if mainViewModel.lockedMessages.isEmpty {
                    EmptyVoidCard()
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 12) {
                            ForEach(mainViewModel.lockedMessages) { message in
                                LockedMessageCard(
                                    sentDate: message.createdAt,
                                    unlockDate: message.unlockAt,
                                    remaining: Self.remainingTimeText(until: message.unlockAt, now: context.date)
                                )
                            }
                        }
                    }
                }
            }
        }
    }

    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    private static func remainingTimeText(until unlockDate: Date, now: Date) -> String {
        let remainingSeconds = max(0, Int(unlockDate.timeIntervalSince(now)))
        let days = remainingSeconds / 86_400
        let hours = (remainingSeconds % 86_400) / 3_600
        let minutes = (remainingSeconds % 3_600) / 60

        if days > 0 {
            return "\(days)d \(hours)h remaining"
        }
        if hours > 0 {
            return "\(hours)h \(minutes)m remaining"
        }
        if remainingSeconds > 0 && minutes == 0 {
            return "<1m remaining"
        }
        return "\(minutes)m remaining"
    }
}

private struct StatusCard: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(AppTheme.secondaryText)
            Spacer()
            Text(value)
                .font(.headline.weight(.semibold))
                .foregroundStyle(AppTheme.primaryText)
                .multilineTextAlignment(.trailing)
        }
        .padding()
        .background(AppTheme.surface)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(AppTheme.elevatedSurface, lineWidth: 1)
        )
    }
}

private struct EmptyVoidCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("The Void is quiet.")
                .font(.headline)
                .foregroundStyle(AppTheme.primaryText)
            Text("No hidden thoughts are waiting right now.")
                .foregroundStyle(AppTheme.secondaryText)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.surface)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(AppTheme.elevatedSurface, lineWidth: 1)
        )
    }
}

private struct LockedMessageCard: View {
    let sentDate: Date
    let unlockDate: Date
    let remaining: String

    private static let timestampFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Sent \(Self.timestampFormatter.string(from: sentDate))")
                .font(.subheadline)
                .foregroundStyle(AppTheme.primaryText)

            Text("Unlocks \(Self.timestampFormatter.string(from: unlockDate))")
                .font(.caption)
                .foregroundStyle(AppTheme.mutedText)

            Text(remaining)
                .font(.caption.weight(.semibold))
                .foregroundStyle(AppTheme.secondaryText)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.surface)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(AppTheme.elevatedSurface, lineWidth: 1)
        )
    }
}

struct VoidStatusView_Previews: PreviewProvider {
    static var previews: some View {
        VoidStatusView(mainViewModel: MainViewModel())
    }
}
