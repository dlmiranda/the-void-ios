//
//  VoidStatusViewModel.swift
//  The Void
//
//  Purpose: Tracks simple status counts for the Void dashboard placeholder.
//

import Foundation
import Combine

final class VoidStatusViewModel: ObservableObject {
    @Published var hiddenCount: Int = 0
    @Published var releasedCount: Int = 0
}
