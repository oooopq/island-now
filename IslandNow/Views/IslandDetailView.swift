//
//  IslandDetailView.swift
//  Island Now
//
//  島をタップしたあとの詳細画面（天気・お役立ち・フェリー・航空便・スポット・ライブカメラ）
//

import SwiftUI

struct IslandDetailView: View {
    let island: Island

    @State private var weatherState: WeatherLoadState = .loading
    @State private var ferryState: FerryLoadState = .loading
    @State private var placesState: PlacesLoadState = .loading
    @State private var selectedPlaceCategory: PlaceCategory = .restaurant

    private let weatherService = WeatherService()
    private let ferryService = FerryService()
    private let placesSearchService = PlacesSearchService()

    private var liveCameras: [LiveCamera] {
        IslandLiveCameras.cameras(for: island.id)
    }

    private var placeSearchTaskID: String {
        island.id + "-" + selectedPlaceCategory.rawValue
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                WeatherSectionView(state: weatherState)

                UsefulInfoSectionView(islandID: island.id)

                FerryScheduleSectionView(island: island, state: ferryState)

                if YonaguniFlightData.supportsFlights(for: island.id) {
                    FlightScheduleSectionView(
                        island: island,
                        schedules: YonaguniFlightData.schedules(for: island.id)
                    )
                }

                PlacesSectionView(
                    island: island,
                    selectedCategory: $selectedPlaceCategory,
                    state: placesState
                )

                LiveCameraSectionView(islandID: island.id, cameras: liveCameras)

                Text(IslandBackgrounds.credit(for: island.id))
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.75))
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
        }
        .background {
            IslandBackgroundView(islandID: island.id)
        }
        .scrollContentBackground(.hidden)
        .navigationTitle(island.nameJapanese)
        .navigationBarTitleDisplayMode(.large)
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        .refreshable {
            await refreshAllData()
        }
        .task(id: island.id) {
            selectedPlaceCategory = .restaurant
            weatherState = .loading
            ferryState = .loading

            async let weatherLoad: Void = loadWeather()
            async let ferryLoad: Void = loadFerrySchedules()
            _ = await (weatherLoad, ferryLoad)
        }
        .task(id: placeSearchTaskID) {
            await loadPlaces()
        }
    }

    @MainActor
    private func refreshAllData() async {
        weatherState = .loading
        ferryState = .loading
        placesState = .loading

        async let weatherLoad: Void = loadWeather()
        async let ferryLoad: Void = loadFerrySchedules()
        async let placesLoad: Void = loadPlaces()
        _ = await (weatherLoad, ferryLoad, placesLoad)
    }

    @MainActor
    private func loadWeather() async {
        if let cached = weatherService.cachedWeather(for: island.id) {
            weatherState = .loaded(cached, isFromCache: true)
        }

        do {
            let weather = try await weatherService.fetchWeather(for: island)
            weatherState = .loaded(weather, isFromCache: false)
        } catch {
            if let cached = weatherService.cachedWeather(for: island.id) {
                weatherState = .failed(
                    message: "最新の天気を取得できませんでした",
                    cachedWeather: cached
                )
                return
            }
            weatherState = .failed(message: "天気を取得できませんでした", cachedWeather: nil)
        }
    }

    @MainActor
    private func loadFerrySchedules() async {
        if let cached = ferryService.cachedSchedules(for: island.id) {
            ferryState = .loaded(cached.schedules, isFromCache: true, validUntilText: cached.validUntilText)
        }

        do {
            let result = try await ferryService.fetchSchedules(for: island)
            ferryState = .loaded(result.schedules, isFromCache: false, validUntilText: result.validUntilText)
        } catch {
            if let cached = ferryService.cachedSchedules(for: island.id) {
                ferryState = .failed(message: "最新のダイヤを取得できませんでした", cachedSchedules: cached.schedules)
                return
            }

            let fallback = IslandSampleData.ferrySchedules(for: island.id)
            ferryState = .loaded(fallback, isFromCache: true, validUntilText: nil)
        }
    }

    @MainActor
    private func loadPlaces() async {
        let category = selectedPlaceCategory

        if let cached = placesSearchService.cachedPlaces(for: island.id, category: category) {
            placesState = .loaded(cached, isFromCache: true)
        } else {
            placesState = .loading
        }

        do {
            let places = try await placesSearchService.searchPlaces(for: island, category: category)
            placesState = .loaded(places, isFromCache: false)
        } catch {
            if let cached = placesSearchService.cachedPlaces(for: island.id, category: category) {
                placesState = .failed(message: "最新のスポットを取得できませんでした", cachedPlaces: cached)
                return
            }
            placesState = .failed(message: "スポットを取得できませんでした", cachedPlaces: nil)
        }
    }
}

#Preview {
    NavigationStack {
        IslandDetailView(island: YaeyamaIslands.all[0])
    }
}
