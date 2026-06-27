//
//  WeatherNoticeBannerView.swift
//  Island Now
//
//  天気セクションの「今日の注意」表示
//

import SwiftUI

struct WeatherNoticeBannerView: View {
    let notices: [String]

    @Environment(\.detailPalette) private var palette

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("今日の注意", systemImage: "exclamationmark.triangle.fill")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(palette.warning)

            ForEach(Array(notices.enumerated()), id: \.offset) { index, notice in
                if index > 0 {
                    Divider()
                }
                Text(notice)
                    .font(.subheadline)
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(palette.noticeBackground)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
