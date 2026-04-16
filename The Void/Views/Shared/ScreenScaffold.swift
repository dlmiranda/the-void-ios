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

            VStack(alignment: .leading, spacing: 22) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(title)
                        .font(.system(.largeTitle, design: .rounded, weight: .bold))
                        .foregroundStyle(AppTheme.primaryText)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(AppTheme.secondaryText)
                }

                content

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 12)
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
