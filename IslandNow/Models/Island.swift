//
//  Island.swift
//  Island Now
//
//  島1件分の基本データ（座標・名前）
//

import CoreLocation
import Foundation

struct Island: Identifiable, Hashable {
    let id: String
    let nameJapanese: String
    let nameEnglish: String
    let latitude: Double
    let longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
