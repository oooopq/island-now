//
//  IslandSavedPhotoStore.swift
//  Island Now
//
//  島ごとのダイヤ写真をアプリ内サンドボックスだけに保存する
//

import Foundation
import UIKit

@Observable
@MainActor
final class IslandSavedPhotoStore {
    private(set) var photos: [IslandSavedPhoto] = []

    private let fileManager = FileManager.default

    private var storageRoot: URL {
        let appSupport = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        return appSupport.appendingPathComponent("IslandSavedPhotos", isDirectory: true)
    }

    func loadPhotos(for islandID: String) {
        ensureStorageDirectoryExists()

        guard let data = try? Data(contentsOf: manifestURL(for: islandID)),
              let decoded = try? JSONDecoder().decode([IslandSavedPhoto].self, from: data) else {
            photos = []
            return
        }

        photos = decoded.sorted { $0.createdAt > $1.createdAt }
    }

    func addPhoto(_ image: UIImage, for islandID: String) {
        ensureStorageDirectoryExists()

        let photoID = UUID().uuidString
        let fileName = "\(photoID).jpg"
        let fileURL = photoFileURL(islandID: islandID, fileName: fileName)

        guard let data = image.jpegData(compressionQuality: 0.85) else { return }

        do {
            try fileManager.createDirectory(at: islandPhotosDirectory(islandID: islandID), withIntermediateDirectories: true)
            try data.write(to: fileURL, options: .atomic)

            var manifest = loadManifest(for: islandID)
            let photo = IslandSavedPhoto(
                id: photoID,
                islandID: islandID,
                fileName: fileName,
                createdAt: Date()
            )
            manifest.append(photo)
            try saveManifest(manifest, for: islandID)
            photos = manifest.sorted { $0.createdAt > $1.createdAt }
        } catch {
            try? fileManager.removeItem(at: fileURL)
        }
    }

    func deletePhoto(_ photo: IslandSavedPhoto) {
        let fileURL = photoFileURL(islandID: photo.islandID, fileName: photo.fileName)
        try? fileManager.removeItem(at: fileURL)

        var manifest = loadManifest(for: photo.islandID)
        manifest.removeAll { $0.id == photo.id }
        try? saveManifest(manifest, for: photo.islandID)
        photos = manifest.sorted { $0.createdAt > $1.createdAt }
    }

    func image(for photo: IslandSavedPhoto) -> UIImage? {
        let fileURL = photoFileURL(islandID: photo.islandID, fileName: photo.fileName)
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return UIImage(data: data)
    }

    private func ensureStorageDirectoryExists() {
        try? fileManager.createDirectory(at: storageRoot, withIntermediateDirectories: true)
    }

    private func islandPhotosDirectory(islandID: String) -> URL {
        storageRoot.appendingPathComponent(islandID, isDirectory: true)
    }

    private func manifestURL(for islandID: String) -> URL {
        storageRoot.appendingPathComponent("\(islandID)-manifest.json")
    }

    private func photoFileURL(islandID: String, fileName: String) -> URL {
        islandPhotosDirectory(islandID: islandID).appendingPathComponent(fileName)
    }

    private func loadManifest(for islandID: String) -> [IslandSavedPhoto] {
        guard let data = try? Data(contentsOf: manifestURL(for: islandID)),
              let decoded = try? JSONDecoder().decode([IslandSavedPhoto].self, from: data) else {
            return []
        }
        return decoded
    }

    private func saveManifest(_ manifest: [IslandSavedPhoto], for islandID: String) throws {
        let data = try JSONEncoder().encode(manifest)
        try data.write(to: manifestURL(for: islandID), options: .atomic)
    }
}
