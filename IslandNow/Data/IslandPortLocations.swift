//
//  IslandPortLocations.swift
//  Island Now
//
//  各島のフェリー港の座標（おおよその値）
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

enum IslandPortLocations {
    static func port(for islandID: String) -> IslandPort? {
        switch islandID {
        case "ishigaki":
            return IslandPort(name: "石垣港", latitude: 24.3397, longitude: 124.1557)
        case "taketomi":
            return IslandPort(name: "竹富港", latitude: 24.3250, longitude: 124.0890)
        case "kuroshima":
            return IslandPort(name: "黒島港", latitude: 24.2457, longitude: 123.8947)
        case "hateruma":
            return IslandPort(name: "波照間港", latitude: 24.0580, longitude: 123.8050)
        case "iriomote":
            return IslandPort(name: "大原港", latitude: 24.4183, longitude: 123.7940)
        case "yonaguni":
            return IslandPort(name: "与那国港", latitude: 24.4670, longitude: 122.9780)
        default:
            return nil
        }
    }

    // 港からスポットまでの距離（メートル）
    static func distanceMeters(from place: PlaceInfo, islandID: String) -> CLLocationDistance? {
        guard let port = port(for: islandID) else { return nil }

        let placeLocation = CLLocation(latitude: place.latitude, longitude: place.longitude)
        let portLocation = CLLocation(latitude: port.latitude, longitude: port.longitude)
        return placeLocation.distance(from: portLocation)
    }

    // 表示用に距離を「450m」「1.2km」形式にする
    static func formattedDistance(_ meters: CLLocationDistance) -> String {
        if meters < 1000 {
            return "\(Int(meters.rounded()))m"
        }
        return String(format: "%.1fkm", meters / 1000)
    }

    // 徒歩速度（約4.8km/h）から徒歩時間を計算する
    private static let walkingSpeedMetersPerMinute: Double = 80

    static func formattedWalkingTime(_ meters: CLLocationDistance) -> String {
        let minutes = max(1, Int((meters / walkingSpeedMetersPerMinute).rounded()))
        if minutes < 60 {
            return "徒歩約\(minutes)分"
        }

        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        if remainingMinutes == 0 {
            return "徒歩約\(hours)時間"
        }
        return "徒歩約\(hours)時間\(remainingMinutes)分"
    }

    // 距離と徒歩時間をまとめて表示する
    static func formattedPortAccess(from place: PlaceInfo, islandID: String) -> String? {
        guard let meters = distanceMeters(from: place, islandID: islandID) else { return nil }
        return "\(formattedDistance(meters))（\(formattedWalkingTime(meters))）"
    }
}
