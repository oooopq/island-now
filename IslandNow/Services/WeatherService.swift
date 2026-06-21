//
//  WeatherService.swift
//  Island Now
//
//  Open-Meteo（無料・APIキー不要）から天気を取得する
//

import Foundation

struct WeatherService {
    private let cacheKeyPrefix = "weather_cache_"

    // 島の座標から天気（現在＋1週間）を取得し、キャッシュにも保存する
    func fetchWeather(for island: Island) async throws -> WeatherInfo {
        let url = try makeURL(latitude: island.latitude, longitude: island.longitude)
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw WeatherServiceError.badResponse
        }

        let decoded = try JSONDecoder().decode(OpenMeteoResponse.self, from: data)
        let weather = decoded.toWeatherInfo()
        saveCache(weather, for: island.id)
        return weather
    }

    // オフライン用：最後に取得した天気を読み出す
    func cachedWeather(for islandID: String) -> WeatherInfo? {
        let key = cacheKeyPrefix + islandID
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }

        if let weather = try? JSONDecoder().decode(WeatherInfo.self, from: data) {
            return weather
        }

        // 古い形式のキャッシュは削除して再取得させる
        UserDefaults.standard.removeObject(forKey: key)
        return nil
    }

    private func saveCache(_ weather: WeatherInfo, for islandID: String) {
        guard let data = try? JSONEncoder().encode(weather) else { return }
        UserDefaults.standard.set(data, forKey: cacheKeyPrefix + islandID)
    }

    private func makeURL(latitude: Double, longitude: Double) throws -> URL {
        var components = URLComponents(string: "https://api.open-meteo.com/v1/forecast")
        components?.queryItems = [
            URLQueryItem(name: "latitude", value: String(latitude)),
            URLQueryItem(name: "longitude", value: String(longitude)),
            URLQueryItem(name: "current", value: "temperature_2m,relative_humidity_2m,wind_speed_10m,weather_code"),
            URLQueryItem(name: "daily", value: "weather_code,temperature_2m_max,temperature_2m_min,relative_humidity_2m_mean"),
            URLQueryItem(name: "forecast_days", value: "7"),
            URLQueryItem(name: "timezone", value: "Asia/Tokyo"),
        ]

        guard let url = components?.url else {
            throw WeatherServiceError.invalidURL
        }
        return url
    }
}

enum WeatherServiceError: Error {
    case invalidURL
    case badResponse
}

// Open-Meteo のレスポンス（必要な部分だけ）
private struct OpenMeteoResponse: Decodable {
    let current: OpenMeteoCurrent
    let daily: OpenMeteoDaily

    func toWeatherInfo() -> WeatherInfo {
        WeatherInfo(
            temperatureCelsius: Int(current.temperature2m.rounded()),
            condition: WeatherConditionMapper.japaneseName(for: current.weatherCode),
            humidityPercent: current.relativeHumidity2m,
            windSpeedKmh: Int(current.windSpeed10m.rounded()),
            weeklyForecast: daily.toWeeklyForecast()
        )
    }
}

private struct OpenMeteoCurrent: Decodable {
    let temperature2m: Double
    let relativeHumidity2m: Int
    let windSpeed10m: Double
    let weatherCode: Int

    enum CodingKeys: String, CodingKey {
        case temperature2m = "temperature_2m"
        case relativeHumidity2m = "relative_humidity_2m"
        case windSpeed10m = "wind_speed_10m"
        case weatherCode = "weather_code"
    }
}

private struct OpenMeteoDaily: Decodable {
    let time: [String]
    let weatherCode: [Int]
    let temperature2mMax: [Double]
    let temperature2mMin: [Double]
    let relativeHumidity2mMean: [Double]

    enum CodingKeys: String, CodingKey {
        case time
        case weatherCode = "weather_code"
        case temperature2mMax = "temperature_2m_max"
        case temperature2mMin = "temperature_2m_min"
        case relativeHumidity2mMean = "relative_humidity_2m_mean"
    }

    func toWeeklyForecast() -> [DailyWeatherForecast] {
        time.indices.map { index in
            DailyWeatherForecast(
                id: time[index],
                dateLabel: WeatherDateFormatter.label(for: time[index]),
                minTemperatureCelsius: Int(temperature2mMin[index].rounded()),
                maxTemperatureCelsius: Int(temperature2mMax[index].rounded()),
                condition: WeatherConditionMapper.japaneseName(for: weatherCode[index]),
                humidityPercent: Int(relativeHumidity2mMean[index].rounded())
            )
        }
    }
}

// 日付文字列を「6/21（土）」形式に変換
private enum WeatherDateFormatter {
    static func label(for dateString: String) -> String {
        let input = DateFormatter()
        input.dateFormat = "yyyy-MM-dd"
        input.timeZone = TimeZone(identifier: "Asia/Tokyo")

        guard let date = input.date(from: dateString) else {
            return dateString
        }

        let output = DateFormatter()
        output.locale = Locale(identifier: "ja_JP")
        output.dateFormat = "M/d（E）"
        output.timeZone = TimeZone(identifier: "Asia/Tokyo")
        return output.string(from: date)
    }
}

// WMO天気コードを日本語に変換
private enum WeatherConditionMapper {
    static func japaneseName(for code: Int) -> String {
        switch code {
        case 0:
            return "晴れ"
        case 1, 2, 3:
            return "くもり"
        case 45, 48:
            return "霧"
        case 51, 53, 55:
            return "小雨"
        case 61, 63, 65:
            return "雨"
        case 71, 73, 75:
            return "雪"
        case 80, 81, 82:
            return "にわか雨"
        case 95, 96, 99:
            return "雷雨"
        default:
            return "不明"
        }
    }
}
