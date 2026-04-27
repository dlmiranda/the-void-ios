//
//  SettingsView.swift
//  The Void
//
//  Purpose: Minimal MVP settings with app info and clear-local-data action.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @ObservedObject var mainViewModel: MainViewModel
    @State private var showClearConfirmation = false
    @StateObject private var tipJarManager = TipJarManager()

    var body: some View {
        ScreenScaffold(
            title: "Settings",
            subtitle: "Minimal controls for this local-only MVP."
        ) {
            VStack(alignment: .leading, spacing: 10) {
                Text("The Void")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(AppTheme.primaryText)

                Text("Send a thought into The Void, and it stays hidden until the time you chose has passed.")
                    .font(.subheadline)
                    .foregroundStyle(AppTheme.secondaryText)

                Text("Version \(appVersionText)")
                    .font(.caption)
                    .foregroundStyle(AppTheme.secondaryText)
            }
            .padding()
            .background(AppTheme.surface)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(AppTheme.elevatedSurface, lineWidth: 1)
            )

            Button(role: .destructive) {
                showClearConfirmation = true
            } label: {
                Text("Clear All Local Data")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            .alert("Clear all local data?", isPresented: $showClearConfirmation) {
                Button("Cancel", role: .cancel) {}
                Button("Clear", role: .destructive) {
                    mainViewModel.clearAllMessages()
                }
            } message: {
                Text("This removes all stored messages from this device.")
            }

            supportSection
        }
        .task {
            await tipJarManager.loadProductsIfNeeded()
        }
    }

    private var appVersionText: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "\(version) (\(build))"
    }

    @ViewBuilder
    private var supportSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Support The Void")
                .font(.headline)
                .foregroundStyle(AppTheme.primaryText)

            Text("The Void is free to use. If it has helped you, you can leave a small optional tip to support continued development.")
                .font(.subheadline)
                .foregroundStyle(AppTheme.secondaryText)

            if tipJarManager.isLoadingProducts {
                ProgressView()
                    .tint(AppTheme.secondaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 6)
            } else {
                ForEach(tipJarManager.products, id: \.id) { product in
                    let details = tipJarManager.displayDetails(for: product)
                    Button {
                        Task {
                            await tipJarManager.purchase(product)
                        }
                    } label: {
                        HStack(alignment: .center, spacing: 12) {
                            VStack(alignment: .leading, spacing: 3) {
                                Text(details.title)
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(AppTheme.primaryText)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                Text(details.description)
                                    .font(.caption)
                                    .foregroundStyle(AppTheme.secondaryText)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }

                            Text(product.displayPrice)
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(AppTheme.secondaryText)
                        }
                        .padding(12)
                        .background(AppTheme.elevatedSurface)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .buttonStyle(.plain)
                    .disabled(tipJarManager.isPurchasing)
                }
            }

            if let status = tipJarManager.statusMessage {
                Text(status)
                    .font(.footnote)
                    .foregroundStyle(AppTheme.secondaryText)
                    .padding(.top, 2)
            }
        }
        .padding()
        .background(AppTheme.surface)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(AppTheme.elevatedSurface, lineWidth: 1)
        )
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(mainViewModel: MainViewModel())
    }
}
