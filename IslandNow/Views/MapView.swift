//
//  MapView.swift
//  Island Now
//
//  日本地図のメイン画面（ピンチでズーム、ドラッグで移動）
//

import MapKit
import SwiftUI

struct MapView: View {
    @State private var viewModel = MapViewModel()

    var body: some View {
        @Bindable var viewModel = viewModel

        NavigationStack {
            Map(position: $viewModel.cameraPosition) {
                ForEach(viewModel.islands) { island in
                    Annotation(island.nameJapanese, coordinate: island.coordinate) {
                        Button {
                            viewModel.selectedIsland = island
                        } label: {
                            Image(systemName: "mappin.circle.fill")
                                .font(.title2)
                                .foregroundStyle(.red)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .mapControls {
                MapCompass()
                MapScaleView()
            }
            .navigationDestination(item: $viewModel.selectedIsland) { island in
                IslandDetailView(island: island)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    AppThemeToggleButton()
                }
            }
        }
    }
}

#Preview {
    MapView()
}
