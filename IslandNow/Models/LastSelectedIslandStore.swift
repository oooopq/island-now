//
//  LastSelectedIslandStore.swift
//  Island Now
//
//  前回開いた島を端末内に記憶する
//

import SwiftUI

@Observable
final class LastSelectedIslandStore {
    private static let storageKey = "lastSelectedIslandID"

    private(set) var islandID: String?

    var island: Island? {
        guard let islandID else { return nil }
        return IslandCatalog.profile(for: islandID)?.island
    }

    init() {
        islandID = UserDefaults.standard.string(forKey: Self.storageKey)
    }

    func record(_ island: Island) {
        islandID = island.id
        UserDefaults.standard.set(island.id, forKey: Self.storageKey)
    }
}
