//
//  Island.swift
//  Island Now
//
//  八重山諸島の1島分のデータ
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
