//
//  IslandSavedPhotosSectionView.swift
//  Island Now
//
//  港や案内所で撮影したダイヤ写真を、端末内だけに保存して表示する
//

import PhotosUI
import SwiftUI

struct IslandSavedPhotosSectionView: View {
    let islandID: String

    @Bindable var store: IslandSavedPhotoStore

    @Environment(\.detailPalette) private var palette
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var showingCamera = false
    @State private var viewingPhoto: IslandSavedPhoto?
    @State private var cameraUnavailableMessage: String?

    private let gridColumns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("写真メモ")
                .font(.headline)

            Text("港や案内所で撮影した時刻表・案内を、この端末内だけに保存できます。サムネイルをタップするとすぐ表示されます。")
                .font(.caption)
                .detailCardSecondaryText()

            addPhotoButtons

            if store.photos.isEmpty {
                emptyState
            } else {
                photoGrid
            }
        }
        .detailSectionCard()
        .task(id: islandID) {
            store.loadPhotos(for: islandID)
        }
        .onChange(of: selectedPhotoItem) { _, newItem in
            guard let newItem else { return }
            Task {
                await importPhoto(from: newItem)
                selectedPhotoItem = nil
            }
        }
        .fullScreenCover(isPresented: $showingCamera) {
            CameraImagePicker { image in
                store.addPhoto(image, for: islandID)
            }
            .ignoresSafeArea()
        }
        .fullScreenCover(item: $viewingPhoto) { photo in
            IslandSavedPhotoViewerView(photo: photo, store: store)
        }
        .alert("カメラを使えません", isPresented: showCameraAlertBinding) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(cameraUnavailableMessage ?? "この端末ではカメラ撮影が利用できません。")
        }
    }

    private var addPhotoButtons: some View {
        HStack(spacing: 10) {
            Button {
                openCamera()
            } label: {
                Label("撮影", systemImage: "camera.fill")
                    .font(.subheadline.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .tint(palette.accent)

            PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                Label("写真を選ぶ", systemImage: "photo.on.rectangle")
                    .font(.subheadline.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.bordered)
        }
    }

    private var emptyState: some View {
        VStack(spacing: 8) {
            Image(systemName: "doc.viewfinder")
                .font(.largeTitle)
                .foregroundStyle(palette.secondaryText)

            Text("まだ写真メモがありません")
                .font(.subheadline)
                .detailCardSecondaryText()
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
    }

    private var photoGrid: some View {
        LazyVGrid(columns: gridColumns, spacing: 10) {
            ForEach(store.photos) { photo in
                photoThumbnail(photo)
            }
        }
    }

    @ViewBuilder
    private func photoThumbnail(_ photo: IslandSavedPhoto) -> some View {
        Button {
            viewingPhoto = photo
        } label: {
            VStack(alignment: .leading, spacing: 6) {
                if let image = store.image(for: photo) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 120)
                        .clipped()
                } else {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(palette.chipBackground(isSelected: false))
                        .frame(height: 120)
                        .overlay {
                            Image(systemName: "photo")
                                .foregroundStyle(palette.secondaryText)
                        }
                }

                Text(formattedDate(photo.createdAt))
                    .font(.caption2)
                    .detailCardSecondaryText()
                    .lineLimit(1)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .strokeBorder(palette.cardBorder, lineWidth: 1)
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(formattedDate(photo.createdAt))の写真メモ")
    }

    private var showCameraAlertBinding: Binding<Bool> {
        Binding(
            get: { cameraUnavailableMessage != nil },
            set: { isPresented in
                if isPresented == false {
                    cameraUnavailableMessage = nil
                }
            }
        )
    }

    private func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            cameraUnavailableMessage = "カメラがない端末、またはシミュレーターでは撮影できません。"
            return
        }
        showingCamera = true
    }

    private func importPhoto(from item: PhotosPickerItem) async {
        guard let data = try? await item.loadTransferable(type: Data.self),
              let image = UIImage(data: data) else {
            return
        }
        store.addPhoto(image, for: islandID)
    }

    private func formattedDate(_ date: Date) -> String {
        date.formatted(date: .abbreviated, time: .shortened)
    }
}

#Preview {
    IslandSavedPhotosSectionView(
        islandID: "ishigaki",
        store: IslandSavedPhotoStore()
    )
    .padding()
    .environment(\.detailPalette, DetailCardPalette.dark)
}
