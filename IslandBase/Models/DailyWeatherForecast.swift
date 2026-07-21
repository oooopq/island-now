//
//  DailyWeatherForecast.swift
//  Island Base
//
//  1日分の天気予報
//

import Foundation

struct DailyWeatherForecast: Codable, Identifiable {
    /// この値未満は晴れ相当として予想降水量行を出さない（Open-Meteo の降水確率定義と同じ 0.1 mm）
    static let precipitationSumDisplayThresholdMillimeters = 0.1

    let id: String
    let dateLabel: String
    let minTemperatureCelsius: Int
    let maxTemperatureCelsius: Int
    let condition: String
    let humidityPercent: Int
    /// 1日の予想降水量合計（mm）
    let precipitationSumMillimeters: Double

    var shouldShowPrecipitationSum: Bool {
        precipitationSumMillimeters >= Self.precipitationSumDisplayThresholdMillimeters
    }
}
