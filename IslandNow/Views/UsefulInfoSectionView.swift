//
//  UsefulInfoSectionView.swift
//  Island Now
//
//  詳細画面のお役立ち情報セクション
//

import SwiftUI

struct UsefulInfoSectionView: View {
    let islandID: String

    @Environment(\.detailPalette) private var palette
    @Environment(AppLanguageStore.self) private var languageStore

    private var items: [UsefulInfo] {
        IslandCatalog.profile(for: islandID)?.usefulInfo ?? []
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(languageStore.t(.usefulInfo))
                .font(.headline)

            ForEach(UsefulInfoCategory.allCases) { category in
                let categoryItems = items.filter { $0.category == category }
                if categoryItems.isEmpty == false {
                    categoryBlock(category: category, items: categoryItems)
                }
            }

            Text(languageStore.t(.usefulInfoDisclaimer))
                .font(.caption)
                .detailCardSecondaryText()
        }
        .detailSectionCard()
    }

    @ViewBuilder
    private func categoryBlock(category: UsefulInfoCategory, items: [UsefulInfo]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(category.title(for: languageStore.mode), systemImage: category.systemImage)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(palette.accent)

            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                if index > 0 {
                    Divider()
                }
                infoRow(item, category: category)
            }
        }
    }

    @ViewBuilder
    private func infoRow(_ item: UsefulInfo, category: UsefulInfoCategory) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: category.systemImage)
                .frame(width: 24)
                .foregroundStyle(palette.iconAccent)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.subheadline)
                    .fontWeight(.medium)

                if let address = item.address, address.isEmpty == false {
                    Text(address)
                        .font(.caption)
                        .detailCardSecondaryText()
                }

                if let phoneNumber = item.phoneNumber, phoneNumber.isEmpty == false {
                    Text(phoneNumber)
                        .font(.caption)
                        .detailCardSecondaryText()
                }

                if let note = item.note, note.isEmpty == false {
                    Text(note)
                        .font(.caption)
                        .detailCardSecondaryText()
                }
            }

            Spacer(minLength: 4)

            DetailRowLinkButtonsView(
                websiteURL: item.websiteLink,
                onNavigate: item.canOpenNavigation ? { item.openDrivingDirections() } : nil
            )
        }
    }
}

#Preview {
    UsefulInfoSectionView(islandID: "ishigaki")
        .padding()
}
