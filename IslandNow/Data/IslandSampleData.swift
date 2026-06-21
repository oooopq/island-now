//
//  IslandSampleData.swift
//  Island Now
//
//  各島のサンプルデータ（API接続前の仮データ）
//

import Foundation

enum IslandSampleData {
    // 八重山でよく使う運営会社（連絡先は各社公式情報）
    private static let yaeyamaFerry = FerryCompany(
        name: "株式会社八重山観光フェリー",
        websiteURL: "https://www.yaeyamaferry.co.jp/",
        phoneNumber: "0570-013-007"
    )

    private static let aneiKanko = FerryCompany(
        name: "安栄観光株式会社",
        websiteURL: "https://www.anei-kanko.co.jp/",
        phoneNumber: "0980-82-4001"
    )

    private static let irimoteJyosen = FerryCompany(
        name: "西表島交通株式会社",
        websiteURL: "https://www.irimote-jyosen.co.jp/",
        phoneNumber: "0980-82-2222"
    )

    static func ferrySchedules(for islandID: String) -> [FerryCompanySchedule] {
        switch islandID {
        case "ishigaki":
            return [
                FerryCompanySchedule(
                    id: "ishigaki-yaeyama",
                    company: yaeyamaFerry,
                    trips: [
                        FerryTrip(id: "1", routeName: "石垣 → 竹富", departureTime: "08:00", arrivalTime: "08:10"),
                        FerryTrip(id: "2", routeName: "石垣 → 西表", departureTime: "09:30", arrivalTime: "10:20"),
                        FerryTrip(id: "3", routeName: "石垣 → 波照間", departureTime: "10:00", arrivalTime: "11:30"),
                    ]
                ),
                FerryCompanySchedule(
                    id: "ishigaki-anei",
                    company: aneiKanko,
                    trips: [
                        FerryTrip(id: "1", routeName: "石垣 → 黒島", departureTime: "07:30", arrivalTime: "08:00"),
                        FerryTrip(id: "2", routeName: "石垣 → 与那国", departureTime: "07:00", arrivalTime: "08:30"),
                    ]
                ),
            ]
        case "taketomi":
            return [
                FerryCompanySchedule(
                    id: "taketomi-yaeyama",
                    company: yaeyamaFerry,
                    trips: [
                        FerryTrip(id: "1", routeName: "竹富 → 石垣", departureTime: "08:30", arrivalTime: "08:40"),
                        FerryTrip(id: "2", routeName: "石垣 → 竹富", departureTime: "14:00", arrivalTime: "14:10"),
                    ]
                ),
            ]
        case "kuroshima":
            return [
                FerryCompanySchedule(
                    id: "kuroshima-anei",
                    company: aneiKanko,
                    trips: [
                        FerryTrip(id: "1", routeName: "石垣 → 黒島", departureTime: "07:30", arrivalTime: "08:00"),
                        FerryTrip(id: "2", routeName: "黒島 → 石垣", departureTime: "16:00", arrivalTime: "16:30"),
                    ]
                ),
            ]
        case "hateruma":
            return [
                FerryCompanySchedule(
                    id: "hateruma-yaeyama",
                    company: yaeyamaFerry,
                    trips: [
                        FerryTrip(id: "1", routeName: "石垣 → 波照間", departureTime: "10:00", arrivalTime: "11:30"),
                        FerryTrip(id: "2", routeName: "波照間 → 石垣", departureTime: "15:00", arrivalTime: "16:30"),
                    ]
                ),
            ]
        case "iriomote":
            return [
                FerryCompanySchedule(
                    id: "iriomote-yaeyama",
                    company: yaeyamaFerry,
                    trips: [
                        FerryTrip(id: "1", routeName: "石垣 → 西表（大原）", departureTime: "08:30", arrivalTime: "09:20"),
                        FerryTrip(id: "2", routeName: "西表（大原） → 石垣", departureTime: "17:00", arrivalTime: "17:50"),
                    ]
                ),
                FerryCompanySchedule(
                    id: "iriomote-jyosen",
                    company: irimoteJyosen,
                    trips: [
                        FerryTrip(id: "1", routeName: "西表（宇波利） → 由布島", departureTime: "09:00", arrivalTime: "09:10"),
                        FerryTrip(id: "2", routeName: "由布島 → 西表（宇波利）", departureTime: "16:00", arrivalTime: "16:10"),
                    ]
                ),
            ]
        case "yonaguni":
            return [
                FerryCompanySchedule(
                    id: "yonaguni-anei",
                    company: aneiKanko,
                    trips: [
                        FerryTrip(id: "1", routeName: "石垣 → 与那国", departureTime: "07:00", arrivalTime: "08:30"),
                        FerryTrip(id: "2", routeName: "与那国 → 石垣", departureTime: "16:30", arrivalTime: "18:00"),
                    ]
                ),
            ]
        default:
            return [
                FerryCompanySchedule(
                    id: "unknown",
                    company: FerryCompany(name: "運航情報なし", websiteURL: "https://www.yaeyamaferry.co.jp/", phoneNumber: ""),
                    trips: [
                        FerryTrip(id: "1", routeName: "運航情報なし", departureTime: "--:--", arrivalTime: "--:--"),
                    ]
                ),
            ]
        }
    }
}
