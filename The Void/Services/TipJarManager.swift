//
//  TipJarManager.swift
//  The Void
//
//  Purpose: Loads optional tip products and handles StoreKit 2 purchases.
//

import Foundation
import Combine
import StoreKit

@MainActor
final class TipJarManager: ObservableObject {
    @Published private(set) var products: [Product] = []
    @Published private(set) var isLoadingProducts = false
    @Published private(set) var isPurchasing = false
    @Published var statusMessage: String?

    private var hasLoadedProducts = false

    private static let productIDs: [String] = [
        "com.snoballproductions.thevoid.tip.quietsignal",
        "com.snoballproductions.thevoid.tip.keepfree",
        "com.snoballproductions.thevoid.tip.deepecho",
        "com.snoballproductions.thevoid.tip.intothevoid"
    ]

    private static let productCopy: [String: (title: String, description: String)] = [
        "com.snoballproductions.thevoid.tip.quietsignal": (
            title: "Quiet Signal",
            description: "A small gesture of support."
        ),
        "com.snoballproductions.thevoid.tip.keepfree": (
            title: "Keep The Void Free",
            description: "Help keep The Void accessible to everyone."
        ),
        "com.snoballproductions.thevoid.tip.deepecho": (
            title: "Deep Echo",
            description: "Support continued development and future features."
        ),
        "com.snoballproductions.thevoid.tip.intothevoid": (
            title: "Into The Void",
            description: "A deeper show of support for the project."
        )
    ]

    func loadProductsIfNeeded() async {
        guard !hasLoadedProducts else { return }
        await loadProducts()
    }

    func loadProducts() async {
        isLoadingProducts = true
        defer { isLoadingProducts = false }

        do {
            let fetchedProducts = try await Product.products(for: Self.productIDs)
            products = fetchedProducts.sorted { $0.price < $1.price }
            hasLoadedProducts = true
            statusMessage = nil
        } catch {
            statusMessage = "Tips are currently unavailable."
        }
    }

    func purchase(_ product: Product) async {
        guard !isPurchasing else { return }
        isPurchasing = true
        defer { isPurchasing = false }

        do {
            let purchaseResult = try await product.purchase()
            switch purchaseResult {
            case .success(let verificationResult):
                switch verificationResult {
                case .verified(let transaction):
                    await transaction.finish()
                    statusMessage = "Thank you for supporting The Void."
                case .unverified:
                    statusMessage = "Purchase could not be verified."
                }
            case .pending:
                statusMessage = "Purchase is pending approval."
            case .userCancelled:
                // Intentionally silent for a calm UX.
                break
            @unknown default:
                statusMessage = "Purchase could not be completed."
            }
        } catch {
            statusMessage = "Could not connect to the App Store right now."
        }
    }

    func displayDetails(for product: Product) -> (title: String, description: String) {
        Self.productCopy[product.id] ?? (title: product.displayName, description: product.description)
    }
}
