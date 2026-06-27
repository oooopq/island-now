//
//  ContentView.swift
//  Island Now
//
//  アプリの最初の画面
//

import SwiftUI

struct ContentView: View {
    @State private var themeStore = AppThemeStore()

    var body: some View {
        MapView()
            .environment(themeStore)
            .environment(\.detailPalette, themeStore.palette)
            .preferredColorScheme(themeStore.colorScheme)
    }
}

#Preview {
    ContentView()
}
