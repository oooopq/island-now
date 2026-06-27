//
//  RegionMapSupport.swift
//  Island Now
//
//  諸島郡マップの表示範囲
//

import CoreLocation
import MapKit
import SwiftUI

enum RegionMapSupport {
    static func cameraPosition(for islands: [Island]) -> MapCameraPosition {
        .region(region(for: islands))
    }

    static func region(for islands: [Island]) -> MKCoordinateRegion {
        guard islands.isEmpty == false else {
            return MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 36.5, longitude: 137.5),
                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            )
        }

        var minLat = islands[0].latitude
        var maxLat = islands[0].latitude
        var minLon = islands[0].longitude
        var maxLon = islands[0].longitude

        for island in islands {
            minLat = min(minLat, island.latitude)
            maxLat = max(maxLat, island.latitude)
            minLon = min(minLon, island.longitude)
            maxLon = max(maxLon, island.longitude)
        }

        let latPadding = max((maxLat - minLat) * 0.35, 0.08)
        let lonPadding = max((maxLon - minLon) * 0.35, 0.08)

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
