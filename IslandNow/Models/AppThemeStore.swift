//
//  AppThemeStore.swift
//  Island Now
//
//  外観モードの保存と切り替え
//

import SwiftUI

@Observable
final class AppThemeStore {
    private static let storageKey = "appThemeMode"

    var mode: AppThemeMode {
        didSet {
            UserDefaults.standard.set(mode.rawValue, forKey: Self.storageKey)
        }
    }

    var palette: DetailCardPalette { mode.palette }
    var colorScheme: ColorScheme { mode.colorScheme }

    init() {
        if let raw = UserDefaults.standard.string(forKey: Self.storageKey),
           let saved = AppThemeMode(rawValue: raw) {
            mode = saved
        } else {
            mode = .dark
        }
    }

    func toggle() {
        mode = mode == .dark ? .light : .dark
    }
}
