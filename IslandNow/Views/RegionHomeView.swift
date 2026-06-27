//
//  RegionHomeView.swift
//  Island Now
//
//  起動画面：諸島郡を選ぶ
//

import SwiftUI

struct RegionHomeView: View {
    @Environment(\.detailPalette) private var palette

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                header

                VStack(spacing: 14) {
                    ForEach(IslandCatalog.regions) { region in
                        NavigationLink(value: region.id) {
                            RegionCardView(region: region)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
        .background(homeBackground)
        .navigationTitle("Island Now")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                AppThemeToggleButton()
            }
        }
        .navigationDestination(for: String.self) { regionID in
            if let region = IslandRegionCatalog.region(for: regionID) {
                RegionIslandsView(region: region)
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("行きたい諸島を選んでください")
                .font(.subheadline)
                .foregroundStyle(palette.secondaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var homeBackground: some View {
        LinearGradient(
            colors: [
                palette.cardBackground.opacity(0.35),
                palette.cardBackground.opacity(0.85),
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

private struct RegionCardView: View {
    let region: IslandRegion

    @Environment(\.detailPalette) private var palette

    private var islandCount: Int {
        IslandCatalog.islandCount(forRegionID: region.id)
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(region.coverAssetName)
                .resizable()
                .scaledToFill()
                .frame(height: 148)
                .clipped()

            LinearGradient(
                colors: [.clear, .black.opacity(0.72)],
                startPoint: .center,
                endPoint: .bottom
            )

            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(region.displayNameJapanese)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)

                    Text("\(islandCount)島")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.85))
                }

                Spacer(minLength: 0)

                Image(systemName: "chevron.right.circle.fill")
                    .font(.title2)
                    .foregroundStyle(.white.opacity(0.9))
            }
            .padding(16)
        }
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(palette.cardBorder, lineWidth: 1)
        }
        .shadow(color: palette.cardShadow, radius: 8, y: 4)
    }
}

#Preview {
    NavigationStack {
        RegionHomeView()
    }
    .environment(AppThemeStore())
    .environment(\.detailPalette, DetailCardPalette.dark)
}
