//
//  IslandRegionCatalog.swift
//  Island Now
//
//  地域（八重山・佐渡・伊豆など）の表示名とフェリー取得元の注記
//

import Foundation

struct IslandRegion: Identifiable, Hashable {
    let id: String
    let displayNameJapanese: String
    /// ホーム画面カード用の背景画像（Assets）
    let coverAssetName: String
    /// フェリーダイヤ取得元の説明（GTFS 取得時のフッター用）
    let ferryDataSourceNote: String?
    /// 有効期限表示の接尾辞（例: OTTOP）
    let ferryValidUntilSuffix: String?
}

enum IslandRegionCatalog {
    static let yaeyama = IslandRegion(
        id: "yaeyama",
        displayNameJapanese: "八重山諸島",
        coverAssetName: "IslandBgIshigaki",
        ferryDataSourceNote: "沖縄公共交通オープンデータ（OTTOP）から取得しています",
        ferryValidUntilSuffix: "（OTTOP公開データ）"
    )

    static let sado = IslandRegion(
        id: "sado",
        displayNameJapanese: "佐渡",
        coverAssetName: "IslandBgSado",
        ferryDataSourceNote: nil,
        ferryValidUntilSuffix: nil
    )

    static let izu = IslandRegion(
        id: "izu",
        displayNameJapanese: "伊豆諸島",
        coverAssetName: "IslandBgIzu",
        ferryDataSourceNote: "東海汽船の代表ダイヤです。高速船（日中）と大型客船（夜航）を分けて表示しています。",
        ferryValidUntilSuffix: nil
    )

    static let all: [IslandRegion] = [yaeyama, sado, izu]

    static func region(for regionID: String) -> IslandRegion? {
        all.first { $0.id == regionID }
    }

    static func displayName(for regionID: String) -> String {
        region(for: regionID)?.displayNameJapanese ?? regionID
    }
}
