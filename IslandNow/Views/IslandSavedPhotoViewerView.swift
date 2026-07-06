//
//  IslandSavedPhotoViewerView.swift
//  Island Now
//
//  保存したダイヤ写真を全画面表示する
//

import SwiftUI

struct IslandSavedPhotoViewerView: View {
    let photo: IslandSavedPhoto
    let store: IslandSavedPhotoStore

    @Environment(\.detailPalette) private var palette
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Group {
                if let image = store.image(for: photo) {
                    ScrollView {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                } else {
                    ContentUnavailableView(
                        "写真を開けません",
                        systemImage: "photo",
                        description: Text("保存データが見つかりませんでした")
                    )
                }
            }
            .background(palette.cardBackground.ignoresSafeArea())
            .navigationTitle(formattedDate(photo.createdAt))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("閉じる") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .destructive) {
                        store.deletePhoto(photo)
                        dismiss()
                    } label: {
                        Image(systemName: "trash")
                    }
                    .accessibilityLabel("写真メモを削除")
                }
            }
        }
    }

    private func formattedDate(_ date: Date) -> String {
        date.formatted(date: .abbreviated, time: .shortened)
    }
}
