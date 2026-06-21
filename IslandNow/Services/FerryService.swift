//
//  FerryService.swift
//  Island Now
//
//  OTTOPのGTFSから本物のフェリーダイヤを取得する
//

import Foundation

struct FerryFetchResult: Codable {
    let schedules: [FerryCompanySchedule]
    let validUntilText: String?
}

struct FerryService {
    private let cacheKeyPrefix = "ferry_cache_"
    private let parser = GTFSFerryParser()

    func fetchSchedules(for island: Island) async throws -> FerryFetchResult {
        let feeds = feeds(for: island)
        var schedules: [FerryCompanySchedule] = []
        var validUntilTexts: [String] = []

        for feed in feeds {
            do {
                let url = feed.downloadURL
                let (data, response) = try await URLSession.shared.data(from: url)

                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    continue
                }

                let files = try GTFSZipReader.extractTextFiles(from: data)
                let trips = parser.parseTrips(from: files, islandID: island.id)

                if let validUntil = parser.validUntilText(from: files) {
                    validUntilTexts.append(validUntil)
                }

                guard trips.isEmpty == false else { continue }

                schedules.append(
                    FerryCompanySchedule(
                        id: "\(island.id)-\(feed.scheduleID)",
                        company: feed.company,
                        trips: trips
                    )
                )
            } catch {
                // 1社分の取得に失敗しても、他社のダイヤは表示する
                continue
            }
        }

        guard schedules.isEmpty == false else {
            throw FerryServiceError.noTripsFound
        }

        let result = FerryFetchResult(
            schedules: schedules,
            validUntilText: validUntilTexts.max()
        )
        saveCache(result, for: island.id)
        return result
    }

    func cachedSchedules(for islandID: String) -> FerryFetchResult? {
        let key = cacheKeyPrefix + islandID
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }

        guard let result = try? JSONDecoder().decode(FerryFetchResult.self, from: data) else {
            UserDefaults.standard.removeObject(forKey: key)
            return nil
        }

        let hasTrips = result.schedules.contains { $0.trips.isEmpty == false }
        guard hasTrips else {
            UserDefaults.standard.removeObject(forKey: key)
            return nil
        }

        return result
    }

    private func feeds(for island: Island) -> [FerryGTFSFeed] {
        switch island.id {
        case "yonaguni":
            return [.fukuyama, .anei, .yaeyamaFerry]
        case "ishigaki":
            return [.anei, .yaeyamaFerry, .fukuyama]
        default:
            return [.anei, .yaeyamaFerry]
        }
    }

    private func saveCache(_ result: FerryFetchResult, for islandID: String) {
        guard let data = try? JSONEncoder().encode(result) else { return }
        UserDefaults.standard.set(data, forKey: cacheKeyPrefix + islandID)
    }
}

enum FerryServiceError: Error {
    case badResponse
    case noTripsFound
}
