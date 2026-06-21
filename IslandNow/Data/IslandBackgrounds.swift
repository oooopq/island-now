//
//  IslandBackgrounds.swift
//  Island Now
//
//  各島の背景画像（Unsplash License / 著作権フリー）
//

import Foundation

enum IslandBackgrounds {
    static func assetName(for islandID: String) -> String {
        switch islandID {
        case "ishigaki":
            return "IslandBgIshigaki"
        case "taketomi":
            return "IslandBgTaketomi"
        case "kuroshima":
            return "IslandBgKuroshima"
        case "hateruma":
            return "IslandBgHateruma"
        case "iriomote":
            return "IslandBgIriomote"
        case "yonaguni":
            return "IslandBgYonaguni"
        default:
            return "IslandBgIshigaki"
        }
    }

    // 画像の出典メモ（Unsplash License）
    static func credit(for islandID: String) -> String {
        switch islandID {
        case "ishigaki":
            return "Photo: Vladimir Haltakov / Unsplash"
        case "taketomi":
            return "Photo: Unsplash"
        case "kuroshima":
            return "Photo: Unsplash（沖縄の海と緑）"
        case "hateruma":
            return "Photo: Unsplash（南国の海）"
        case "iriomote":
            return "Photo: Unsplash（森と自然）"
        case "yonaguni":
            return "Photo: Unsplash（荒波の海）"
        default:
            return "Photo: Unsplash"
        }
    }
}
