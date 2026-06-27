//
//  HourlyWeatherForecast.swift
//  Island Now
//
//  時間帯ごとの天気（今日の3時間おき表示用）
//

import Foundation

struct HourlyWeatherForecast: Codable, Identifiable {
    let id: String
    let timeLabel: String
    let temperatureCelsius: Int
    let condition: String
    let humidityPercent: Int
    let precipitationProbabilityPercent: Int
}
