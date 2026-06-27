//
//  WeatherInfo.swift
//  Island Now
//
//  1島分の天気情報（現在＋1週間予報）
//

import Foundation

struct WeatherInfo: Codable {
    let temperatureCelsius: Int
    let condition: String
    let humidityPercent: Int
    let windSpeedKmh: Int
    /// 現在の有義波高（メートル）。取得できない場合は nil
    let currentWaveHeightMeters: Double?
    /// 今日の最大有義波高（メートル）。取得できない場合は nil
    let todayMaxWaveHeightMeters: Double?
    let todayHourlyForecast: [HourlyWeatherForecast]
    let weeklyForecast: [DailyWeatherForecast]
}
