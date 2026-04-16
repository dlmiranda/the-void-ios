//
//  ReleasedViewModel.swift
//  The Void
//
//  Purpose: Supplies released-screen state for placeholder and upcoming data wiring.
//

import Foundation
import Combine

final class ReleasedViewModel: ObservableObject {
    @Published var releasedMessages: [VoidMessage] = []
}
