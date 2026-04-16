//
//  ReleasedView.swift
//  The Void
//
//  Purpose: Placeholder released screen where unlocked messages will appear.
//

import SwiftUI

struct ReleasedView: View {
    @StateObject private var viewModel: ReleasedViewModel

    init(messageStore: MessageStore) {
        _viewModel = StateObject(wrappedValue: ReleasedViewModel(messageStore: messageStore))
    }

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
                ForEach(viewModel.releasedMessages) { message in
                    Text(message.text)
                        .foregroundStyle(AppTheme.primaryText)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(AppTheme.surface)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
        }
        .onAppear {
            viewModel.refresh()
        }
    }
}

struct ReleasedView_Previews: PreviewProvider {
    static var previews: some View {
        ReleasedView(messageStore: MessageStore())
    }
}
