//
//  IslandUserLocationFullMapView.swift
//  Island Now
//
//  島・港・現在地を全画面マップで表示する
//

import CoreLocation
import MapKit
import SwiftUI

struct IslandUserLocationFullMapView: View {
    let island: Island
    let islandProfile: IslandProfile?
    let userCoordinate: CLLocationCoordinate2D?
    let authorizationStatus: CLAuthorizationStatus

    @Environment(\.detailPalette) private var palette
    @State private var cameraPosition: MapCameraPosition = .automatic

    var body: some View {
        Map(position: $cameraPosition, interactionModes: [.pan, .zoom, .rotate]) {
            UserAnnotation()

            IslandUserLocationMapSupport.annotations(
                island: island,
                islandProfile: islandProfile,
                userCoordinate: userCoordinate,
                palette: palette,
                showsUserLocationAnnotation: false
            )
        }
        .mapStyle(.standard(elevation: .realistic))
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
        .navigationTitle("現在地")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            updateCamera()
        }
        .onChange(of: userCoordinate?.latitude) { _, _ in
            updateCamera()
        }
        .onChange(of: userCoordinate?.longitude) { _, _ in
            updateCamera()
        }
    }

    private func updateCamera() {
        cameraPosition = .region(
            IslandUserLocationMapSupport.mapRegion(
                island: island,
                islandProfile: islandProfile,
                userCoordinate: userCoordinate
            )
        )
    }
}

#Preview {
    NavigationStack {
        IslandUserLocationFullMapView(
            island: IslandCatalog.islands[0],
            islandProfile: IslandCatalog.profile(for: "ishigaki"),
            userCoordinate: nil,
            authorizationStatus: .authorizedWhenInUse
        )
    }
}
