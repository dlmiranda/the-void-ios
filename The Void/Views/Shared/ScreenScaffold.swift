//
//  ScreenScaffold.swift
//  The Void
//
//  Purpose: Reusable wrapper for consistent page layout and dark background styling.
//

import SwiftUI

struct ScreenScaffold<Content: View>: View {
    let title: String
    let subtitle: String
    @ViewBuilder let content: Content

    var body: some View {
        ZStack {
            AppTheme.background
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(title)
                        .font(.largeTitle.bold())
                        .foregroundStyle(AppTheme.primaryText)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(AppTheme.secondaryText)
                }

                content

                Spacer()
            }
            .padding(20)
        }
    }
}

struct ScreenScaffold_Previews: PreviewProvider {
    static var previews: some View {
        ScreenScaffold(title: "Preview", subtitle: "Shared scaffold preview") {
            Text("Content")
                .foregroundStyle(AppTheme.primaryText)
        }
    }
}
