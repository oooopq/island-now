//
//  AppBrandTitleView.swift
//  Island Now
//
//  アプリ名のワードマーク
//

import SwiftUI

struct AppBrandTitleView: View {
    enum Style {
        case hero
        case compact
    }

    let style: Style

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        switch style {
        case .hero:
            heroTitle
        case .compact:
            compactTitle
        }
    }

    private var heroTitle: some View {
        HStack(alignment: .firstTextBaseline, spacing: 2) {
            Text("Island")
                .font(.system(size: 34, weight: .light, design: .serif))
                .foregroundStyle(brandDeepBlue)
                .tracking(0.5)

            Text("Now")
                .font(.system(size: 34, weight: .bold, design: .serif))
                .foregroundStyle(brandDeepBlue)
                .tracking(0.2)
        }
    }

    private var compactTitle: some View {
        HStack(alignment: .firstTextBaseline, spacing: 1) {
            Text("Island")
                .font(.system(size: 17, weight: .light, design: .serif))
                .foregroundStyle(brandDeepBlue)
                .tracking(0.3)

            Text("Now")
                .font(.system(size: 17, weight: .bold, design: .serif))
                .foregroundStyle(brandDeepBlue)
        }
    }

    // 海・島を連想させるブルー（Island / Now 共通）
    private var brandDeepBlue: Color {
        switch colorScheme {
        case .dark:
            // ダークモード：明るいマリンブルー（暗い背景でも見やすく）
            return Color(red: 0.28, green: 0.68, blue: 0.92)
        default:
            // ライトモード：ディープブルー
            return Color(red: 0.01, green: 0.14, blue: 0.32)
        }
    }
}

#Preview("Hero Dark") {
    AppBrandTitleView(style: .hero)
        .padding()
        .background(Color.black)
        .environment(\.detailPalette, DetailCardPalette.dark)
        .preferredColorScheme(.dark)
}

#Preview("Hero Light") {
    AppBrandTitleView(style: .hero)
        .padding()
        .background(Color.white)
        .environment(\.detailPalette, DetailCardPalette.light)
        .preferredColorScheme(.light)
}

#Preview("Compact") {
    AppBrandTitleView(style: .compact)
        .padding()
        .background(Color.black)
        .environment(\.detailPalette, DetailCardPalette.dark)
}
