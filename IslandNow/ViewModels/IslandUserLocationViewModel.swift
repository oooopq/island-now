//
//  IslandUserLocationViewModel.swift
//  Island Now
//
//  現在地カードの距離・島内外判定・表示文言を組み立てる
//

import CoreLocation
import Foundation

struct IslandUserLocationStatus {
    let isOnIsland: Bool
    let summaryText: String
    let portAccessLines: [String]
}

@MainActor
struct IslandUserLocationViewModel {
    /// MVP固定値。石垣島など大きい島と波照間島など小さい島では最適値が異なる。
    static let islandProximityThresholdMeters: CLLocationDistance = 10_000

    let island: Island

    func status(for userCoordinate: CLLocationCoordinate2D) -> IslandUserLocationStatus {
        let distanceFromCenter = distanceFromIslandCenter(from: userCoordinate)
        let isOnIsland = distanceFromCenter <= Self.islandProximityThresholdMeters

        if isOnIsland {
            return IslandUserLocationStatus(
                isOnIsland: true,
                summaryText: "島内にいます",
                portAccessLines: IslandCatalog.formattedPortAccessLines(
                    from: userCoordinate,
                    islandID: island.id,
                    includeWalkingTime: true
                )
            )
        }

        return IslandUserLocationStatus(
            isOnIsland: false,
            summaryText: "この島から \(IslandCatalog.formattedDistance(distanceFromCenter)) の位置にいます",
            portAccessLines: []
        )
    }

    private func distanceFromIslandCenter(from coordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        let userLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let islandLocation = CLLocation(latitude: island.latitude, longitude: island.longitude)
        return userLocation.distance(from: islandLocation)
    }
}
