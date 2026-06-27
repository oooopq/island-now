//
//  LastSelectedIslandShortcutView.swift
//  Island Now
//
//  前回選択した島へ戻るショートカット
//

import SwiftUI

struct LastSelectedIslandShortcutView: View {
    let island: Island

    @Environment(\.detailPalette) private var palette

    private var backgroundAssetName: String {
        IslandCatalog.profile(for: island)?.backgroundAssetName ?? IslandCatalog.defaultBackgroundAssetName
    }

    var body: some View {
        NavigationLink(value: island) {
            HStack(spacing: 8) {
                Image(backgroundAssetName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                VStack(alignment: .leading, spacing: 2) {
                    Text("前回の島")
                        .font(.caption2)
                        .foregroundStyle(palette.secondaryText)

                    Text(island.nameJapanese)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(palette.text)
                        .lineLimit(1)
                }

                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundStyle(palette.accent)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(palette.cardBackground.opacity(0.92))
                    .overlay {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .strokeBorder(palette.cardBorder, lineWidth: 1)
                    }
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        LastSelectedIslandShortcutView(island: IslandCatalog.islands[0])
            .padding()
    }
    .environment(\.detailPalette, DetailCardPalette.dark)
}
