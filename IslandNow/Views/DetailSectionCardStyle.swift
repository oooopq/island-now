//
//  DetailSectionCardStyle.swift
//  Island Now
//
//  背景写真の上でも読みやすいダーク系カードスタイル
//

import SwiftUI

enum DetailCardTheme {
    static let text = Color.white.opacity(0.92)
    static let secondaryText = Color.white.opacity(0.58)
    static let accent = Color(red: 0.25, green: 0.82, blue: 0.95)
    static let iconAccent = Color(red: 1.0, green: 0.62, blue: 0.38)
    static let warning = Color.orange
    static let cardBackground = Color(red: 0.08, green: 0.11, blue: 0.16).opacity(0.90)
    static let cardBorder = Color.white.opacity(0.12)
    static let noticeBackground = Color.orange.opacity(0.18)
    static let bannerBackground = Color(red: 0.25, green: 0.82, blue: 0.95).opacity(0.14)

    static func chipBackground(isSelected: Bool) -> Color {
        isSelected ? accent.opacity(0.32) : Color.white.opacity(0.10)
    }

    static func chipForeground(isSelected: Bool) -> Color {
        isSelected ? accent : secondaryText
    }
}

struct DetailSectionCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(DetailCardTheme.text)
            .tint(DetailCardTheme.accent)
            .colorScheme(.dark)
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(DetailCardTheme.cardBackground)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .strokeBorder(DetailCardTheme.cardBorder, lineWidth: 1)
                    }
                    .shadow(color: .black.opacity(0.30), radius: 8, y: 4)
            }
    }
}

extension View {
    func detailSectionCard() -> some View {
        modifier(DetailSectionCardStyle())
    }

    /// カード内の補助テキスト用
    func detailCardSecondaryText() -> some View {
        foregroundStyle(DetailCardTheme.secondaryText)
    }
}
