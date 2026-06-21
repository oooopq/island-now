//
//  IslandFerryFilter.swift
//  Island Now
//
//  島IDごとに表示する航路を絞り込む
//

import Foundation

enum IslandFerryFilter {
    static func matches(routeLongName: String, islandID: String) -> Bool {
        switch islandID {
        case "ishigaki":
            return routeLongName.contains("石垣")
        case "taketomi":
            return routeLongName.contains("竹富")
        case "kuroshima":
            return routeLongName.contains("黒島")
        case "hateruma":
            return routeLongName.contains("波照間")
        case "iriomote":
            return routeLongName.contains("大原")
                || routeLongName.contains("上原")
                || routeLongName.contains("西表")
        case "yonaguni":
            return routeLongName.contains("与那国")
        default:
            return false
        }
    }
}
