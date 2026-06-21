//
//  IslandPlaceSearch.swift
//  Island Now
//
//  島ごとのスポット検索範囲（メートル）
//

import CoreLocation
import Foundation

enum IslandPlaceSearch {
    // 島の大きさに合わせて検索半径を変える
    static func searchRadius(for islandID: String) -> CLLocationDistance {
        switch islandID {
        case "ishigaki", "iriomote":
            return 18_000
        case "taketomi", "kuroshima":
            return 6_000
        case "hateruma", "yonaguni":
            return 10_000
        default:
            return 12_000
        }
    }

    // 一覧に表示する最大件数
    static let displayLimit = 20
}
