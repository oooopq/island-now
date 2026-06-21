//
//  IslandUsefulInfo.swift
//  Island Now
//
//  各島のお役立ち情報（公式サイト等をもとにした代表情報）
//

import Foundation

enum IslandUsefulInfo {
    static func items(for islandID: String) -> [UsefulInfo] {
        switch islandID {
        case "ishigaki":
            return ishigakiItems
        case "taketomi":
            return taketomiItems
        case "kuroshima":
            return kuroshimaItems
        case "hateruma":
            return haterumaItems
        case "iriomote":
            return iriomoteItems
        case "yonaguni":
            return yonaguniItems
        default:
            return []
        }
    }

    private static let ishigakiItems: [UsefulInfo] = [
        UsefulInfo(
            id: "ishigaki-hospital",
            category: .medical,
            name: "石垣市立南ぬ島ふれあい病院",
            phoneNumber: "0980-82-8181",
            address: "沖縄県石垣市字真栄里249",
            websiteURL: "https://www.city.ishigaki.okinawa.jp/hospital/",
            note: "八重山の中核病院（救急対応）"
        ),
        UsefulInfo(
            id: "ishigaki-convenience",
            category: .convenience,
            name: "離島ターミナル・市街地周辺",
            phoneNumber: nil,
            address: "石垣港・美崎町・730交差点付近",
            websiteURL: nil,
            note: "セブン-イレブン、ローソン、ゆうちょATMなど"
        ),
        UsefulInfo(
            id: "ishigaki-tourism",
            category: .tourism,
            name: "石垣市観光交流協会",
            phoneNumber: "0980-82-2808",
            address: "沖縄県石垣市真栄里283",
            websiteURL: "https://www.yaeyama.or.jp/",
            note: "観光案内・イベント情報"
        ),
    ]

    private static let taketomiItems: [UsefulInfo] = [
        UsefulInfo(
            id: "taketomi-clinic",
            category: .medical,
            name: "竹富診療所",
            phoneNumber: "0980-85-2133",
            address: "沖縄県竹富町竹富402",
            websiteURL: nil,
            note: "平日診療（詳細は要確認）"
        ),
        UsefulInfo(
            id: "taketomi-convenience",
            category: .convenience,
            name: "竹富港・集落周辺",
            phoneNumber: nil,
            address: "竹富港から徒歩圏内",
            websiteURL: nil,
            note: "コンビニ・ATMは集落内に少数"
        ),
        UsefulInfo(
            id: "taketomi-tourism",
            category: .tourism,
            name: "竹富町観光協会",
            phoneNumber: "0980-85-2441",
            address: "沖縄県竹富町竹富",
            websiteURL: "https://www.taketomijima.jp/",
            note: "水牛車・サイクル観光の案内"
        ),
    ]

    private static let kuroshimaItems: [UsefulInfo] = [
        UsefulInfo(
            id: "kuroshima-clinic",
            category: .medical,
            name: "黒島診療所",
            phoneNumber: "0980-95-2211",
            address: "沖縄県竹富町黒島",
            websiteURL: nil,
            note: nil
        ),
        UsefulInfo(
            id: "kuroshima-convenience",
            category: .convenience,
            name: "黒島港周辺",
            phoneNumber: nil,
            address: "黒島港・集落",
            websiteURL: nil,
            note: "店舗は限られます。現金の用意を"
        ),
        UsefulInfo(
            id: "kuroshima-tourism",
            category: .tourism,
            name: "黒島観光案内（竹富町）",
            phoneNumber: "0980-85-2441",
            address: "竹富町役場観光課",
            websiteURL: "https://www.taketomijima.jp/",
            note: "黒島は竹富町に属します"
        ),
    ]

    private static let haterumaItems: [UsefulInfo] = [
        UsefulInfo(
            id: "hateruma-clinic",
            category: .medical,
            name: "波照間診療所",
            phoneNumber: "0980-85-8120",
            address: "沖縄県竹富町波照間",
            websiteURL: nil,
            note: nil
        ),
        UsefulInfo(
            id: "hateruma-convenience",
            category: .convenience,
            name: "港・集落周辺の店舗",
            phoneNumber: nil,
            address: "波照間港付近",
            websiteURL: nil,
            note: "コンビニ・ATMは少なめです"
        ),
        UsefulInfo(
            id: "hateruma-tourism",
            category: .tourism,
            name: "波照間島観光案内",
            phoneNumber: "0980-85-8767",
            address: "沖縄県竹富町波照間",
            websiteURL: "https://www.hateruma-guide.com/",
            note: "最南端の碑・星空観測など"
        ),
    ]

    private static let iriomoteItems: [UsefulInfo] = [
        UsefulInfo(
            id: "iriomote-clinic-west",
            category: .medical,
            name: "西表西部診療所（上原）",
            phoneNumber: "0980-85-9111",
            address: "沖縄県竹富町上原",
            websiteURL: nil,
            note: "大原港方面の診療所"
        ),
        UsefulInfo(
            id: "iriomote-clinic-east",
            category: .medical,
            name: "西表東部診療所（大原）",
            phoneNumber: "0980-85-9110",
            address: "沖縄県竹富町大原",
            websiteURL: nil,
            note: "上原港方面の診療所"
        ),
        UsefulInfo(
            id: "iriomote-convenience",
            category: .convenience,
            name: "大原・上原の港周辺",
            phoneNumber: nil,
            address: "各港の集落",
            websiteURL: nil,
            note: "大原港・上原港付近に店舗・ATM"
        ),
        UsefulInfo(
            id: "iriomote-tourism",
            category: .tourism,
            name: "西表島観光協会",
            phoneNumber: "0980-85-6185",
            address: "沖縄県竹富町大原",
            websiteURL: "https://www.iriomote.com/",
            note: "カヤック・トレッキング等の案内"
        ),
    ]

    private static let yonaguniItems: [UsefulInfo] = [
        UsefulInfo(
            id: "yonaguni-clinic",
            category: .medical,
            name: "与那国診療所",
            phoneNumber: "0980-87-2133",
            address: "沖縄県与那国町与那国",
            websiteURL: nil,
            note: nil
        ),
        UsefulInfo(
            id: "yonaguni-convenience",
            category: .convenience,
            name: "久部良港・集落周辺",
            phoneNumber: nil,
            address: "与那国港付近",
            websiteURL: nil,
            note: "店舗は限られます"
        ),
        UsefulInfo(
            id: "yonaguni-tourism",
            category: .tourism,
            name: "与那国町観光協会",
            phoneNumber: "0980-87-2441",
            address: "沖縄県与那国町与那国",
            websiteURL: "https://welcome-yonaguni.jp/",
            note: "最西端の碑・ダイビング等"
        ),
    ]
}
