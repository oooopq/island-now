//
//  IslandSavedPhoto.swift
//  Island Now
//
//  島ごとに端末内へ保存したダイヤ写真のメタデータ
//

import Foundation

struct IslandSavedPhoto: Identifiable, Codable, Hashable {
    let id: String
    let islandID: String
    let fileName: String
    let createdAt: Date
}
