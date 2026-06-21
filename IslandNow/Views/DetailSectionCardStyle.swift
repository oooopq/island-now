//
//  DetailSectionCardStyle.swift
//  Island Now
//
//  背景写真の上でも読みやすいカードスタイル
//

import SwiftUI

private enum DetailCardColors {
    static let text = Color(red: 0.12, green: 0.12, blue: 0.12)
    static let secondaryText = Color(red: 0.45, green: 0.45, blue: 0.45)
}

struct DetailSectionCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(DetailCardColors.text)
            .tint(.blue)
            .colorScheme(.light)
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.white.opacity(0.96))
                    .shadow(color: .black.opacity(0.10), radius: 6, y: 2)
            }
    }
}

extension View {
    func detailSectionCard() -> some View {
        modifier(DetailSectionCardStyle())
    }

    /// カード内の補助テキスト用（暗い背景の影響を受けない）
    func detailCardSecondaryText() -> some View {
        foregroundStyle(DetailCardColors.secondaryText)
    }
}
