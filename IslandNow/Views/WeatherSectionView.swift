//
//  WeatherSectionView.swift
//  Island Now
//
//  詳細画面の天気セクション（現在＋1週間予報）
//

import SwiftUI

struct WeatherSectionView: View {
    let state: WeatherLoadState

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("天気")
                .font(.headline)

            switch state {
            case .loading:
                ProgressView("天気を取得中…")
                    .tint(.blue)
                    .detailCardSecondaryText()

            case .loaded(let weather, let isFromCache):
                currentWeatherContent(weather)
                weeklyForecastContent(weather.weeklyForecast)
                if isFromCache {
                    Text("前回取得したデータを表示中")
                        .font(.caption)
                        .detailCardSecondaryText()
                }

            case .failed(let message, let cachedWeather):
                Text(message)
                    .font(.subheadline)
                    .foregroundStyle(.orange)
                if let cachedWeather {
                    currentWeatherContent(cachedWeather)
                    weeklyForecastContent(cachedWeather.weeklyForecast)
                    Text("オフライン用の保存データです")
                        .font(.caption)
                        .detailCardSecondaryText()
                }
            }
        }
        .detailSectionCard()
    }

    @ViewBuilder
    private func currentWeatherContent(_ weather: WeatherInfo) -> some View {
        Text("現在")
            .font(.subheadline)
            .detailCardSecondaryText()

        HStack(alignment: .center, spacing: 16) {
            WeatherIconView(condition: weather.condition, iconSize: 56)

            VStack(alignment: .leading, spacing: 4) {
                Text("\(weather.temperatureCelsius)°C")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text(weather.condition)
                    .font(.title3)

                Label("湿度 \(weather.humidityPercent)%", systemImage: "humidity")
                    .font(.subheadline)
                    .detailCardSecondaryText()
            }
        }

        Label("風速 \(weather.windSpeedKmh) km/h", systemImage: "wind")
            .font(.subheadline)
            .detailCardSecondaryText()

        WeatherNoticeBannerView(notices: WeatherNoticeHelper.notices(for: weather))
    }

    @ViewBuilder
    private func weeklyForecastContent(_ forecast: [DailyWeatherForecast]) -> some View {
        Divider()
            .padding(.vertical, 4)

        Text("1週間の予報")
            .font(.subheadline)
            .detailCardSecondaryText()

        ForEach(forecast) { day in
            HStack(spacing: 8) {
                Text(day.dateLabel)
                    .frame(width: 88, alignment: .leading)
                WeatherIconView(condition: day.condition, iconSize: 20)
                Text(day.condition)
                    .frame(maxWidth: .infinity, alignment: .leading)
                VStack(alignment: .trailing, spacing: 2) {
                    Text("\(day.minTemperatureCelsius)° / \(day.maxTemperatureCelsius)°")
                    Text("湿度 \(day.humidityPercent)%")
                        .font(.caption)
                }
                .detailCardSecondaryText()
            }
            .font(.subheadline)
        }
    }
}

#Preview {
    WeatherSectionView(
        state: .loaded(
            WeatherInfo(
                temperatureCelsius: 28,
                condition: "晴れ",
                humidityPercent: 72,
                windSpeedKmh: 14,
                weeklyForecast: [
                    DailyWeatherForecast(
                        id: "2026-06-21",
                        dateLabel: "6/21（土）",
                        minTemperatureCelsius: 24,
                        maxTemperatureCelsius: 29,
                        condition: "晴れ",
                        humidityPercent: 72
                    ),
                ]
            ),
            isFromCache: false
        )
    )
    .padding()
}
