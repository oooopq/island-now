//
//  PlacesSectionView.swift
//  Island Now
//
//  詳細画面のスポットセクション（飲食店・宿・商店）
//

import SwiftUI

struct PlacesSectionView: View {
    let island: Island
    @Binding var selectedCategory: PlaceCategory
    let state: PlacesLoadState

    private var showsPortDistance: Bool {
        selectedCategory == .restaurant || selectedCategory == .lodging
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("スポット")
                .font(.headline)

            Picker("カテゴリ", selection: $selectedCategory) {
                ForEach(PlaceCategory.allCases) { category in
                    Text(category.rawValue).tag(category)
                }
            }
            .pickerStyle(.segmented)

            if showsPortDistance, let port = IslandCatalog.port(for: island.id) {
                Text("港（\(port.name)）からの距離・徒歩時間を表示しています")
                    .font(.caption)
                    .detailCardSecondaryText()
            }

            switch state {
            case .loading:
                ProgressView("スポットを検索中…")
                    .tint(DetailCardTheme.accent)
                    .detailCardSecondaryText()

            case .loaded(let places, let isFromCache):
                if places.isEmpty {
                    Text("このカテゴリのスポットが見つかりませんでした")
                        .font(.subheadline)
                        .detailCardSecondaryText()
                } else {
                    let visiblePlaces = Array(places.prefix(IslandCatalog.placeDisplayLimit))
                    ForEach(Array(visiblePlaces.enumerated()), id: \.element.id) { index, place in
                        if index > 0 {
                            Divider()
                        }
                        placeRow(place)
                    }

                    if places.count > IslandCatalog.placeDisplayLimit {
                        Text("ほか \(places.count - IslandCatalog.placeDisplayLimit) 件")
                            .font(.caption)
                            .detailCardSecondaryText()
                    }
                }

                if isFromCache {
                    Text("前回取得したデータを表示中")
                        .font(.caption)
                        .detailCardSecondaryText()
                } else {
                    Text("Apple マップのデータを表示しています")
                        .font(.caption)
                        .detailCardSecondaryText()
                }

            case .failed(let message, let cachedPlaces):
                Text(message)
                    .font(.subheadline)
                    .foregroundStyle(DetailCardTheme.warning)

                if let cachedPlaces, cachedPlaces.isEmpty == false {
                    ForEach(Array(cachedPlaces.prefix(IslandCatalog.placeDisplayLimit))) { place in
                        placeRow(place)
                    }
                    Text("オフライン用の保存データです")
                        .font(.caption)
                        .detailCardSecondaryText()
                }
            }
        }
        .detailSectionCard()
    }

    @ViewBuilder
    private func placeRow(_ place: PlaceInfo) -> some View {
        if let url = place.mapsURL {
            Link(destination: url) {
                placeRowContent(place, showsMapIcon: true)
            }
        } else {
            placeRowContent(place, showsMapIcon: false)
        }
    }

    private func placeRowContent(_ place: PlaceInfo, showsMapIcon: Bool) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: iconName(for: place.categoryLabel))
                .frame(width: 24)
                .foregroundStyle(DetailCardTheme.iconAccent)

            VStack(alignment: .leading, spacing: 4) {
                Text(place.name)
                    .font(.subheadline)
                    .fontWeight(.medium)

                if showsPortDistance, let accessText = portAccessText(for: place) {
                    Label("港から \(accessText)", systemImage: "figure.walk")
                        .font(.caption)
                        .detailCardSecondaryText()
                }

                if let address = place.address, address != place.name {
                    Text(address)
                        .font(.caption)
                        .detailCardSecondaryText()
                }

                if let phoneNumber = place.phoneNumber, phoneNumber.isEmpty == false {
                    Text(phoneNumber)
                        .font(.caption)
                        .detailCardSecondaryText()
                }
            }

            Spacer(minLength: 8)

            if showsMapIcon {
                Image(systemName: "map")
                    .font(.caption)
                    .detailCardSecondaryText()
            }
        }
    }

    private func portAccessText(for place: PlaceInfo) -> String? {
        IslandCatalog.formattedPortAccess(from: place, islandID: island.id)
    }

    private func iconName(for categoryLabel: String) -> String {
        switch categoryLabel {
        case PlaceCategory.restaurant.rawValue:
            return "fork.knife"
        case PlaceCategory.lodging.rawValue:
            return "bed.double.fill"
        case PlaceCategory.shop.rawValue:
            return "bag.fill"
        default:
            return "mappin.and.ellipse"
        }
    }
}

#Preview {
    PlacesSectionView(
        island: IslandCatalog.islands[0],
        selectedCategory: .constant(.restaurant),
        state: .loaded(
            [
                PlaceInfo(
                    id: "1",
                    name: "八重山そば 示例",
                    categoryLabel: "飲食店",
                    address: "沖縄県石垣市",
                    latitude: 24.34,
                    longitude: 124.15,
                    phoneNumber: "0980-00-0000",
                    mapsURLString: "https://maps.apple.com/"
                ),
            ],
            isFromCache: false
        )
    )
    .padding()
}
