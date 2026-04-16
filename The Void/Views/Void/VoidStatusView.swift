//
//  VoidStatusView.swift
//  The Void
//
//  Purpose: Placeholder status dashboard for hidden and released totals.
//

import SwiftUI

struct VoidStatusView: View {
    @StateObject private var viewModel = VoidStatusViewModel()

    var body: some View {
        ScreenScaffold(
            title: "Void",
            subtitle: "A quick snapshot of your hidden thoughts."
        ) {
            StatusCard(title: "Hidden", value: "\(viewModel.hiddenCount)")
            StatusCard(title: "Released", value: "\(viewModel.releasedCount)")
        }
    }
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
        VoidStatusView()
    }
}
