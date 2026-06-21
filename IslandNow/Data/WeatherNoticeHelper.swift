//
//  WeatherNoticeHelper.swift
//  Island Now
//
//  天気データから「今日の注意」メッセージを作る
//

import Foundation

enum WeatherNoticeHelper {
    // 現在の天気と今日の予報から注意事項を返す
    static func notices(for weather: WeatherInfo) -> [String] {
        var notices: [String] = []

        if weather.windSpeedKmh >= 30 {
            notices.append("風が強いため、フェリーや航空便の遅延・欠航が出る可能性があります。")
        } else if weather.windSpeedKmh >= 20 {
            notices.append("風がやや強いです。船の揺れに注意してください。")
        }

        if weather.humidityPercent >= 85 {
            notices.append("湿度が高いです。熱中症と天候の急変に注意してください。")
        } else if weather.humidityPercent >= 75, weather.temperatureCelsius >= 28 {
            notices.append("蒸し暑い日です。こまめな水分補給を心がけてください。")
        }

        if isRainy(weather.condition) {
            notices.append("雨のため、海のレジャーや長時間の屋外活動は中止を検討してください。")
        }

        if isStormy(weather.condition) {
            notices.append("強い雨や雷の可能性があります。屋外活動は避けてください。")
        }

        if let todayForecast = weather.weeklyForecast.first, isRainy(todayForecast.condition) {
            if isRainy(weather.condition) == false {
                notices.append("今日の予報は\(todayForecast.condition)です。午後から天候が変わる可能性があります。")
            }
        }

        if notices.isEmpty {
            notices.append("今日は大きな注意はありません。比較的穏やかな天気です。")
        }

        return notices
    }

    private static func isRainy(_ condition: String) -> Bool {
        condition.contains("雨") || condition.contains("霧")
    }

    private static func isStormy(_ condition: String) -> Bool {
        condition.contains("雷雨")
    }
}
