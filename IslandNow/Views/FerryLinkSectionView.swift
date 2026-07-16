//
//  FerryLinkSectionView.swift
//  Island Now
//
//  GTFS 非対応地域向け：各社公式サイトへのリンクのみ
//

import SwiftUI

struct FerryLinkSectionView: View {
    let companies: [FerryCompany]

    @Environment(\.detailPalette) private var palette
    @Environment(AppLanguageStore.self) private var languageStore

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(languageStore.t(.ferry))
                    .font(.headline)
                Text(languageStore.t(.ferryAndHighSpeed))
                    .font(.caption)
                    .detailCardSecondaryText()
            }

            Text(languageStore.t(.ferryCheckOfficialSites))
                .font(.caption)
                .detailCardSecondaryText()
                .fixedSize(horizontal: false, vertical: true)

            ForEach(Array(companies.enumerated()), id: \.element.name) { index, company in
                companyBlock(company)

                if index < companies.count - 1 {
                    Divider()
                }
            }
        }
        .detailSectionCard()
    }

    @ViewBuilder
    private func companyBlock(_ company: FerryCompany) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(company.name)
                .font(.subheadline)
                .fontWeight(.semibold)

            ScheduleOperatorActionButtonsView(
                actions: company.linkButtons.map { ScheduleOperatorActionFactory.actions(for: $0, language: languageStore.mode) }
            )
        }
    }
}

#Preview {
    FerryLinkSectionView(
        companies: IslandCatalog.profile(for: "oshima")?.ferryLinkCompanies ?? []
    )
    .padding()
    .environment(AppLanguageStore())
    .environment(\.detailPalette, DetailCardPalette.dark)
}
