//
//  IslandDetailSection.swift
//  Island Now
//
//  島詳細画面で切り替えるセクション
//

import SwiftUI

enum IslandDetailSection: String, CaseIterable, Identifiable {
    case weather
    case schedule
    case places
    case savedPhotos

    var id: String { rawValue }

    var title: String {
        switch self {
        case .weather:
            return "天気"
        case .schedule:
            return "ダイヤ"
        case .places:
            return "店舗"
        case .savedPhotos:
            return "写真メモ"
        }
    }

    var systemImage: String {
        switch self {
        case .weather:
            return "cloud.sun.fill"
        case .schedule:
            return "ferry.fill"
        case .places:
            return "bag.fill"
        case .savedPhotos:
            return "doc.viewfinder"
        }
    }

    /// セクションタブのアイコン色
    var iconColor: Color {
        switch self {
        case .weather:
            return Color(red: 1.0, green: 0.72, blue: 0.18)
        case .schedule:
            return Color(red: 0.18, green: 0.68, blue: 1.0)
        case .places:
            return Color(red: 0.22, green: 0.82, blue: 0.52)
        case .savedPhotos:
            return Color(red: 1.0, green: 0.36, blue: 0.52)
        }
    }

    /// 選択中タブのグラデーション
    var tabGradient: LinearGradient {
        switch self {
        case .weather:
            return LinearGradient(
                colors: [
                    Color(red: 1.0, green: 0.88, blue: 0.35),
                    Color(red: 1.0, green: 0.58, blue: 0.12),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .schedule:
            return LinearGradient(
                colors: [
                    Color(red: 0.45, green: 0.86, blue: 1.0),
                    Color(red: 0.12, green: 0.52, blue: 0.98),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .places:
            return LinearGradient(
                colors: [
                    Color(red: 0.52, green: 0.96, blue: 0.68),
                    Color(red: 0.14, green: 0.72, blue: 0.46),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .savedPhotos:
            return LinearGradient(
                colors: [
                    Color(red: 1.0, green: 0.58, blue: 0.72),
                    Color(red: 0.92, green: 0.24, blue: 0.48),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
}
