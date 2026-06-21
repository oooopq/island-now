//
//  FerryGTFSFeed.swift
//  Island Now
//
//  OTTOP（沖縄公共交通オープンデータ）のフェリーGTFS情報
//

import Foundation

enum FerryGTFSFeed: String, CaseIterable {
    case anei = "4360002020964"
    case yaeyamaFerry = "6360001013190"
    case fukuyama = "5360003005096"

    var downloadURL: URL {
        URL(string: "https://api3.ottop.org/download/gtfs/ooXuXei4op7y/\(rawValue)")!
    }

    var company: FerryCompany {
        switch self {
        case .anei:
            return FerryCompany(
                name: "安栄観光株式会社",
                websiteURL: "https://www.anei-kanko.co.jp/",
                phoneNumber: "0980-82-4001"
            )
        case .yaeyamaFerry:
            return FerryCompany(
                name: "株式会社八重山観光フェリー",
                websiteURL: "https://www.yaeyamaferry.co.jp/",
                phoneNumber: "0570-013-007"
            )
        case .fukuyama:
            return FerryCompany(
                name: "福山海運株式会社",
                websiteURL: "https://www.fukushimakaiun.com/",
                phoneNumber: "0980-82-5011"
            )
        }
    }

    var scheduleID: String {
        rawValue
    }
}
