//
//  YaeyamaIslands.swift
//  Island Now
//
//  八重山諸島の島リスト（座標はおおよその値）
//  新しい島を追加するときは、この配列に1行足すだけ
//

import Foundation

enum YaeyamaIslands {
    static let all: [Island] = [
        Island(id: "ishigaki", nameJapanese: "石垣島", nameEnglish: "Ishigaki", latitude: 24.3444, longitude: 124.1572),
        Island(id: "taketomi", nameJapanese: "竹富島", nameEnglish: "Taketomi", latitude: 24.3256, longitude: 124.0850),
        Island(id: "kuroshima", nameJapanese: "黒島", nameEnglish: "Kuroshima", latitude: 24.2450, longitude: 123.8956),
        Island(id: "hateruma", nameJapanese: "波照間島", nameEnglish: "Hateruma", latitude: 24.0583, longitude: 123.8061),
        Island(id: "iriomote", nameJapanese: "西表島", nameEnglish: "Iriomote", latitude: 24.4167, longitude: 123.8167),
        Island(id: "yonaguni", nameJapanese: "与那国島", nameEnglish: "Yonaguni", latitude: 24.4667, longitude: 122.9833),
    ]
}
