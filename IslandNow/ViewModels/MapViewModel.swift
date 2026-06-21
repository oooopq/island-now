//
//  MapViewModel.swift
//  Island Now
//
//  マップ画面の状態（カメラ位置・島リスト）
//

import MapKit
import Observation
import SwiftUI

@Observable
final class MapViewModel {
    // 起動時は日本全体が見える位置
    var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 36.5, longitude: 137.5),
            span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 22)
        )
    )

    let islands = YaeyamaIslands.all

    // タップされた島（詳細画面への遷移用）
    var selectedIsland: Island?
}
