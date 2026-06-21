//
//  IslandDetailViewModel.swift
//  Island Now
//
//  島の詳細画面のデータ
//

import Foundation
import Observation

@MainActor
@Observable
final class IslandDetailViewModel {
    let island: Island
    let liveCamera: LiveCamera

    var weatherState: WeatherLoadState = .loading
    var ferryState: FerryLoadState = .loading

    private let weatherService = WeatherService()
    private let ferryService = FerryService()

    init(island: Island) {
        self.island = island
        self.liveCamera = IslandLiveCameras.cameras(for: island.id).first
            ?? LiveCamera(title: "ライブカメラ", urlString: "https://www.youtube.com")
    }

    // 画面表示のたびに天気とフェリーを読み込む
    func reloadAll() async {
        weatherState = .loading
        ferryState = .loading

        async let weatherLoad: Void = loadWeather()
        async let ferryLoad: Void = loadFerrySchedules()
        _ = await (weatherLoad, ferryLoad)
    }

    func loadWeather() async {
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

    func loadFerrySchedules() async {
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
}
