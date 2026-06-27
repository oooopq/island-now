//
//  ImageCreditsView.swift
//  Island Now
//
//  背景画像の提供元・ライセンス一覧（公開・法務向け）
//

import SwiftUI

struct ImageCreditsView: View {
    @Environment(\.detailPalette) private var palette

    private var entries: [IslandCatalog.BackgroundCreditEntry] {
        IslandCatalog.backgroundCreditEntries
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                introSection
                islandCreditsSection
                licenseNotesSection
            }
            .padding(16)
        }
        .background(listBackground)
        .navigationTitle("画像提供・ライセンス")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var introSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("このアプリでは、各島の詳細画面背景に以下の画像素材を使用しています。")
                .font(.subheadline)
                .foregroundStyle(palette.text)

            Text("出典表記は各画像のライセンス条件に従います。")
                .font(.caption)
                .foregroundStyle(palette.secondaryText)
        }
        .creditCardStyle(palette: palette)
    }

    private var islandCreditsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("島別の背景画像")
                .font(.headline)
                .foregroundStyle(palette.text)

            ForEach(entries) { entry in
                VStack(alignment: .leading, spacing: 6) {
                    Text(entry.islandNameJapanese)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(palette.text)

                    Text(entry.regionNameJapanese)
                        .font(.caption)
                        .foregroundStyle(palette.secondaryText)

                    Text(entry.credit)
                        .font(.caption)
                        .foregroundStyle(palette.text)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .creditCardStyle(palette: palette)
            }
        }
    }

    private var licenseNotesSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("ライセンスについて")
                .font(.headline)
                .foregroundStyle(palette.text)

            licenseNote(
                title: "Unsplash License",
                body: "商用・非商用を問わず利用できます。クレジット表示は任意ですが、本アプリでは提供元を明示しています。"
            )

            licenseNote(
                title: "Wikimedia Commons",
                body: "各画像に記載の Creative Commons ライセンス（CC BY / CC BY-SA など）に従い、作者名とライセンスを表示しています。"
            )

            licenseNote(
                title: "アプリアイコン",
                body: "Island Now 用のオリジナルデザインです（第三者の画像素材は使用していません）。"
            )
        }
    }

    private func licenseNote(title: String, body: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(palette.text)

            Text(body)
                .font(.caption)
                .foregroundStyle(palette.secondaryText)
                .fixedSize(horizontal: false, vertical: true)
        }
        .creditCardStyle(palette: palette)
    }

    private var listBackground: some View {
        palette.cardBackground.opacity(0.15)
            .ignoresSafeArea()
    }
}

private extension View {
    func creditCardStyle(palette: DetailCardPalette) -> some View {
        frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(palette.cardBackground)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .strokeBorder(palette.cardBorder, lineWidth: 1)
                    }
            }
    }
}

#Preview {
    NavigationStack {
        ImageCreditsView()
    }
    .environment(AppThemeStore())
    .environment(\.detailPalette, DetailCardPalette.dark)
}
