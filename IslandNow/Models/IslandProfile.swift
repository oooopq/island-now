//
//  IslandProfile.swift
//  Island Now
//
//  1島ぶんの設定（座標・港・背景・フェリーなど）をまとめる
//

import CoreLocation
import Foundation

struct IslandPort {
    let name: String
    let latitude: Double
    let longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct IslandProfile: Identifiable {
    let island: Island
    let regionID: String
    let port: IslandPort?
    let backgroundAssetName: String
    let backgroundCredit: String
    let placeSearchRadiusMeters: CLLocationDistance
    /// 航路名・港名の判定用（例: 「石垣」「大原」）
    let routeKeywords: [String]
    let ferryGTFSFeeds: [FerryGTFSFeed]
    let sampleFerrySchedules: [FerryCompanySchedule]
    let usefulInfo: [UsefulInfo]
    let liveCameras: [LiveCamera]
    let flightSchedules: [FlightAirlineSchedule]
    let flightScheduleNote: String?

    var id: String { island.id }

    func matchesRoute(_ routeLongName: String) -> Bool {
        routeKeywords.contains { routeLongName.contains($0) }
    }

    func matchesPlaceName(_ placeName: String) -> Bool {
        routeKeywords.contains { placeName.contains($0) }
    }

    func distanceMeters(from place: PlaceInfo) -> CLLocationDistance? {
        guard let port else { return nil }

        let placeLocation = CLLocation(latitude: place.latitude, longitude: place.longitude)
        let portLocation = CLLocation(latitude: port.latitude, longitude: port.longitude)
        return placeLocation.distance(from: portLocation)
    }
}
