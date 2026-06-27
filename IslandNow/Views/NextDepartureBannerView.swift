//
//  NextDepartureBannerView.swift
//  Island Now
//
//  「次の便」を強調表示するバナー
//

import SwiftUI

struct NextDepartureBannerView: View {
    let title: String
    let departures: [UpcomingDeparture]
    let showsTomorrowNote: Bool

    @Environment(\.detailPalette) private var palette

    var body: some View {
        if departures.isEmpty == false {
            VStack(alignment: .leading, spacing: 10) {
                Label(title, systemImage: "clock.fill")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(palette.accent)

                if showsTomorrowNote {
                    Text("本日の出港便は終了しました。翌日の最初の便です。")
                        .font(.caption)
                        .foregroundStyle(palette.warning)
                }

                ForEach(Array(departures.enumerated()), id: \.element.id) { index, departure in
                    if index > 0 {
                        Divider()
                    }
                    departureRow(departure)
                }
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(palette.bannerBackground)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }

    @ViewBuilder
    private func departureRow(_ departure: UpcomingDeparture) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(departure.routeText)
                .font(.subheadline)
                .fontWeight(.medium)

            HStack {
                Text("\(departure.departureTime) 発")
                Spacer()
                Text("\(departure.arrivalTime) 着")
            }
            .font(.caption)
            .detailCardSecondaryText()

            if let detailText = departure.detailText, detailText.isEmpty == false {
                Text(detailText)
                    .font(.caption)
                    .detailCardSecondaryText()
            }
        }
    }
}
