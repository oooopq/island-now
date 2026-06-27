//
//  ContentView.swift
//  Island Now
//
//  アプリの最初の画面
//

import SwiftUI

struct ContentView: View {
    @State private var themeStore = AppThemeStore()
    @State private var lastSelectedIslandStore = LastSelectedIslandStore()

    var body: some View {
        NavigationStack {
            RegionHomeView()
        }
        .environment(themeStore)
        .environment(lastSelectedIslandStore)
        .environment(\.detailPalette, themeStore.palette)
        .preferredColorScheme(themeStore.colorScheme)
    }
}

#Preview {
    ContentView()
}
