//
//  YonaguniFlightData.swift
//  Island Now
//
//  与那国線の航空便ダイヤ（琉球エアコミューター）
//  出典: 南ぬ島石垣空港・与那国観光WEB（2026年夏ダイヤ）
//

import Foundation

enum YonaguniFlightData {
    private static let rac = FlightAirline(
        name: "琉球エアコミューター（JALグループ）",
        websiteURL: "https://www.jal.co.jp/jp/ja/dom/flights/route/yonaguni/",
        phoneNumber: "0570-025-031"
    )

    // 航空便セクションを表示する島
    static func supportsFlights(for islandID: String) -> Bool {
        islandID == "yonaguni" || islandID == "ishigaki"
    }

    static func schedules(for islandID: String) -> [FlightAirlineSchedule] {
        guard supportsFlights(for: islandID) else { return [] }

        return [
            FlightAirlineSchedule(
                id: "yonaguni-rac",
                airline: rac,
                trips: allTrips()
            ),
        ]
    }

    static let scheduleNote = "2026年夏ダイヤ時点。季節により変更があります。"

    private static func allTrips() -> [FlightTrip] {
        [
            // 那覇 ↔ 与那国（1日2往復）
            FlightTrip(id: "rac721", flightNumber: "RAC721", routeName: "那覇 → 与那国", departureTime: "07:15", arrivalTime: "08:30"),
            FlightTrip(id: "rac727", flightNumber: "RAC727", routeName: "那覇 → 与那国", departureTime: "14:55", arrivalTime: "16:10"),
            FlightTrip(id: "rac724", flightNumber: "RAC724", routeName: "与那国 → 那覇", departureTime: "11:25", arrivalTime: "12:45"),
            FlightTrip(id: "rac728", flightNumber: "RAC728", routeName: "与那国 → 那覇", departureTime: "18:50", arrivalTime: "20:10"),

            // 石垣 ↔ 与那国（1日3往復）
            FlightTrip(id: "rac741", flightNumber: "RAC741", routeName: "石垣 → 与那国", departureTime: "10:05", arrivalTime: "10:35"),
            FlightTrip(id: "rac743", flightNumber: "RAC743", routeName: "石垣 → 与那国", departureTime: "12:35", arrivalTime: "13:05"),
            FlightTrip(id: "rac747", flightNumber: "RAC747", routeName: "石垣 → 与那国", departureTime: "17:50", arrivalTime: "18:20"),
            FlightTrip(id: "rac742", flightNumber: "RAC742", routeName: "与那国 → 石垣", departureTime: "09:05", arrivalTime: "09:35"),
            FlightTrip(id: "rac744", flightNumber: "RAC744", routeName: "与那国 → 石垣", departureTime: "13:40", arrivalTime: "14:10"),
            FlightTrip(id: "rac746", flightNumber: "RAC746", routeName: "与那国 → 石垣", departureTime: "16:50", arrivalTime: "17:20"),
        ]
    }
}
