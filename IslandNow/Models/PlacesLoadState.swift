//
//  PlacesLoadState.swift
//  Island Now
//
//  スポットセクションの表示状態
//

import Foundation

enum PlacesLoadState: Equatable {
    case loading
    case loaded([PlaceInfo], isFromCache: Bool)
    case failed(message: String, cachedPlaces: [PlaceInfo]?)
}
