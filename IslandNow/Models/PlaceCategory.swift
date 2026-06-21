//
//  PlaceCategory.swift
//  Island Now
//
//  スポット検索のカテゴリ（飲食店・宿・商店）
//

import MapKit

enum PlaceCategory: String, CaseIterable, Identifiable {
    case restaurant = "飲食店"
    case lodging = "宿"
    case shop = "商店"

    var id: String { rawValue }

    var systemImage: String {
        switch self {
        case .restaurant:
            return "fork.knife"
        case .lodging:
            return "bed.double.fill"
        case .shop:
            return "bag.fill"
        }
    }

    // Apple マップの POI カテゴリに対応づける
    var mapKitCategories: [MKPointOfInterestCategory] {
        switch self {
        case .restaurant:
            return [.restaurant, .cafe, .bakery, .foodMarket]
        case .lodging:
            return [.hotel, .campground]
        case .shop:
            return [.store, .foodMarket, .pharmacy]
        }
    }
}
