//
//  RegionMapSupport.swift
//  Island Base
//
//  諸島郡マップの表示範囲
//

import CoreLocation
import MapKit
import SwiftUI

enum RegionMapSupport {
    static func japanHomeCameraPosition() -> MapCameraPosition {
        .region(japanOverviewRegion())
    }

    /// 起動時の基準画角（`japanHomeMapEnvelope` と同じ）
    static func japanOverviewRegion() -> MKCoordinateRegion {
        japanHomeMapEnvelope()
    }

    /// トップ地図のカメラ制限（起動画角と同じ範囲に固定）
    static var japanMapCameraBounds: MapCameraBounds {
        let envelope = japanHomeMapEnvelope()
        let distance = cameraDistanceToFit(region: envelope)
        return MapCameraBounds(
            centerCoordinateBounds: envelope,
            minimumDistance: distance,
            maximumDistance: distance
        )
    }

    /// ホーム地図の画角。登録済み地域ピンだけから計算し、地域追加で自動拡張する
    private static func japanHomeMapEnvelope() -> MKCoordinateRegion {
        let pins = IslandRegionCatalog.all.map(\.mapCoordinate)
        guard pins.isEmpty == false else {
            return MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 36.5, longitude: 137.5),
                span: MKCoordinateSpan(latitudeDelta: 14, longitudeDelta: 14)
            )
        }

        var minLat = pins.map(\.latitude).min() ?? 36.5
        var maxLat = pins.map(\.latitude).max() ?? 36.5
        var minLon = pins.map(\.longitude).min() ?? 137.5
        var maxLon = pins.map(\.longitude).max() ?? 137.5

        let latSpan = max(maxLat - minLat, 1.0)
        let lonSpan = max(maxLon - minLon, 1.0)

        // ピン範囲に対する比率で余白（南控えめ・北多めでラベル用。大陸・フィリピンは入れない）
        minLat -= max(latSpan * 0.08, 1.0)
        maxLat += max(latSpan * 0.22, 3.0)
        minLon -= max(lonSpan * 0.12, 2.0)
        maxLon += max(lonSpan * 0.12, 2.0)

        let latitudeDelta = max(maxLat - minLat, 14)
        let longitudeDelta = max(maxLon - minLon, 14)

        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: (minLat + maxLat) / 2,
                longitude: (minLon + maxLon) / 2
            ),
            span: MKCoordinateSpan(
                latitudeDelta: latitudeDelta,
                longitudeDelta: longitudeDelta
            )
        )
    }

    private static func cameraDistanceToFit(region: MKCoordinateRegion) -> CLLocationDistance {
        let latRadians = region.center.latitude * .pi / 180
        let latMeters = region.span.latitudeDelta * 111_000
        let lonMeters = region.span.longitudeDelta * 111_000 * max(cos(latRadians), 0.35)
        return max(latMeters, lonMeters) * 2.2
    }

    static func cameraPosition(for islands: [Island]) -> MapCameraPosition {
        .region(region(for: islands))
    }

    static func region(for islands: [Island]) -> MKCoordinateRegion {
        boundingRegion(
            for: islands.map(\.coordinate),
            minimumPadding: 0.08,
            paddingRatio: 0.35
        )
    }

    private static func boundingRegion(
        for coordinates: [CLLocationCoordinate2D],
        minimumPadding: Double,
        paddingRatio: Double
    ) -> MKCoordinateRegion {
        guard coordinates.isEmpty == false else {
            return MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 36.5, longitude: 137.5),
                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            )
        }

        var minLat = coordinates[0].latitude
        var maxLat = coordinates[0].latitude
        var minLon = coordinates[0].longitude
        var maxLon = coordinates[0].longitude

        for coordinate in coordinates {
            minLat = min(minLat, coordinate.latitude)
            maxLat = max(maxLat, coordinate.latitude)
            minLon = min(minLon, coordinate.longitude)
            maxLon = max(maxLon, coordinate.longitude)
        }

        let latPadding = max((maxLat - minLat) * paddingRatio, minimumPadding)
        let lonPadding = max((maxLon - minLon) * paddingRatio, minimumPadding)

        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: (minLat + maxLat) / 2,
                longitude: (minLon + maxLon) / 2
            ),
            span: MKCoordinateSpan(
                latitudeDelta: (maxLat - minLat) + latPadding,
                longitudeDelta: (maxLon - minLon) + lonPadding
            )
        )
    }
}
