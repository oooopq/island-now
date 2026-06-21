//
//  FerryRouteHelper.swift
//  Island Now
//
//  フェリー航路名から島を判別し、行き先で絞り込む
//

import Foundation

struct FerryDestination: Identifiable, Hashable {
    let id: String
    let nameJapanese: String
}

enum FerryRouteHelper {
    static let allDestinationsID = "all"

    // 「石垣 → 竹富」形式を出発地と到着地に分ける
    static func parseRoute(_ routeName: String) -> (departure: String, arrival: String)? {
        let separator = " → "
        guard let range = routeName.range(of: separator) else { return nil }

        let departure = String(routeName[..<range.lowerBound]).trimmingCharacters(in: .whitespaces)
        let arrival = String(routeName[range.upperBound...]).trimmingCharacters(in: .whitespaces)

        guard departure.isEmpty == false, arrival.isEmpty == false else { return nil }
        return (departure, arrival)
    }

    // 港名・停留所名から島IDを推定する
    static func islandID(for placeName: String) -> String? {
        if placeName.contains("石垣") { return "ishigaki" }
        if placeName.contains("竹富") { return "taketomi" }
        if placeName.contains("黒島") { return "kuroshima" }
        if placeName.contains("波照間") { return "hateruma" }
        if placeName.contains("与那国") { return "yonaguni" }
        if placeName.contains("西表") || placeName.contains("大原") || placeName.contains("上原") || placeName.contains("由布") {
            return "iriomote"
        }
        return nil
    }

    // 今見ている島以外の相手島IDを返す
    static func partnerIslandID(for trip: FerryTrip, currentIslandID: String) -> String? {
        guard let route = parseRoute(trip.routeName) else { return nil }

        let departureID = islandID(for: route.departure)
        let arrivalID = islandID(for: route.arrival)

        if departureID == currentIslandID {
            return arrivalID
        }
        if arrivalID == currentIslandID {
            return departureID
        }

        return arrivalID ?? departureID
    }

    // ダイヤ一覧に含まれる行き先島のリストを作る
    static func destinations(in schedules: [FerryCompanySchedule], currentIslandID: String) -> [FerryDestination] {
        var islandIDs = Set<String>()

        for schedule in schedules {
            for trip in schedule.trips {
                if let partnerID = partnerIslandID(for: trip, currentIslandID: currentIslandID) {
                    islandIDs.insert(partnerID)
                }
            }
        }

        return islandIDs
            .sorted { displayName(for: $0) < displayName(for: $1) }
            .map { FerryDestination(id: $0, nameJapanese: displayName(for: $0)) }
    }

    static func displayName(for islandID: String) -> String {
        YaeyamaIslands.all.first { $0.id == islandID }?.nameJapanese ?? islandID
    }

    // 選択した行き先に合う便だけ残す
    static func filteredTrips(_ trips: [FerryTrip], destinationID: String, currentIslandID: String) -> [FerryTrip] {
        guard destinationID != allDestinationsID else { return trips }

        return trips.filter { trip in
            partnerIslandID(for: trip, currentIslandID: currentIslandID) == destinationID
        }
    }
}
