//
//  ReleasedView.swift
//  The Void
//
//  Purpose: Placeholder released screen where unlocked messages will appear.
//

import SwiftUI

struct ReleasedView: View {
    @StateObject private var viewModel = ReleasedViewModel()

    var body: some View {
        ScreenScaffold(
            title: "Released",
            subtitle: "Thoughts appear here after their unlock time."
        ) {
            if viewModel.releasedMessages.isEmpty {
                Text("Nothing released yet.")
                    .font(.headline)
                    .foregroundStyle(AppTheme.secondaryText)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(AppTheme.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            } else {
                Text("Released messages will show here.")
                    .foregroundStyle(AppTheme.primaryText)
            }
        }
    }
}

struct ReleasedView_Previews: PreviewProvider {
    static var previews: some View {
        ReleasedView()
    }
}
