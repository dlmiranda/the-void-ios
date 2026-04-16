//
//  VoidStatusView.swift
//  The Void
//
//  Purpose: Placeholder status dashboard for hidden and released totals.
//

import SwiftUI

struct VoidStatusView: View {
    @ObservedObject var mainViewModel: MainViewModel

    var body: some View {
        ScreenScaffold(
            title: "Void",
            subtitle: "A quick snapshot of your hidden thoughts."
        ) {
            StatusCard(title: "Hidden", value: "\(mainViewModel.lockedCount)")
            StatusCard(title: "Released", value: "\(mainViewModel.releasedMessages.count)")
            StatusCard(
                title: "Next Unlock",
                value: mainViewModel.nextUnlockTime.map(Self.timeFormatter.string(from:)) ?? "None"
            )
        }
    }

    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}

private struct StatusCard: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(AppTheme.secondaryText)
            Spacer()
            Text(value)
                .font(.title3.bold())
                .foregroundStyle(AppTheme.primaryText)
        }
        .padding()
        .background(AppTheme.surface)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

struct VoidStatusView_Previews: PreviewProvider {
    static var previews: some View {
        VoidStatusView(mainViewModel: MainViewModel())
    }
}
