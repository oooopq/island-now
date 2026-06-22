//
//  LiveCameraSectionView.swift
//  Island Now
//
//  詳細画面のライブカメラセクション
//

import SwiftUI

struct LiveCameraSectionView: View {
    let islandID: String
    let cameras: [LiveCamera]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("ライブカメラ")
                .font(.headline)

            if cameras.isEmpty {
                Text("この島のライブカメラ情報は準備中です")
                    .font(.subheadline)
                    .detailCardSecondaryText()
            } else {
                ForEach(Array(cameras.enumerated()), id: \.element.id) { index, camera in
                    if index > 0 {
                        Divider()
                    }
                    cameraRow(camera)
                }
            }

            Text(footnoteText)
                .font(.caption)
                .detailCardSecondaryText()
        }
        .detailSectionCard()
    }

    private var footnoteText: String {
        if islandID == "yonaguni" {
            return "※ 海上保安庁の灯台カメラはスマホで真っ白になることがあります。上のYouTubeリンクをお試しください。"
        }
        return "※ 配信停止・メンテナンス中の場合があります。"
    }

    @ViewBuilder
    private func cameraRow(_ camera: LiveCamera) -> some View {
        if let url = URL(string: camera.urlString) {
            Link(destination: url) {
                HStack {
                    Image(systemName: "video.fill")
                    Text(camera.title)
                    Spacer()
                    Image(systemName: "arrow.up.right")
                }
                .font(.subheadline)
            }
        } else {
            Text(camera.title)
                .font(.subheadline)
                .detailCardSecondaryText()
        }
    }
}

#Preview {
    LiveCameraSectionView(
        islandID: "ishigaki",
        cameras: IslandCatalog.profile(for: "ishigaki")?.liveCameras ?? []
    )
        .padding()
}
