//
//  AppThemeToggleButton.swift
//  Island Now
//
//  ダーク / ライト切り替えボタン
//

import SwiftUI

struct AppThemeToggleButton: View {
    @Environment(AppThemeStore.self) private var themeStore

    var body: some View {
        Button {
            themeStore.toggle()
        } label: {
            Image(systemName: themeStore.mode.toggleSystemImage)
        }
        .accessibilityLabel(themeStore.mode.accessibilityLabel)
    }
}
