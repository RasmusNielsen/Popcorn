//
//  SavedMoviesDataStorage.swift
//  Popcorn
//
//  Created by Kasper Kronborg on 06/03/2023.
//

import Foundation

final class SavedMoviesDataStorage {
    static private let decoder = PropertyListDecoder()
    static private let encoder = PropertyListEncoder()

    static private func fileUrl() throws -> URL {
        let dir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let url = dir.appending(path: "SavedMovies.plist")
        return url
    }

    static private func fileData() -> Data? {
        guard let fileURL = try? Self.fileUrl() else { return nil }
        return try? Data(contentsOf: fileURL)
    }

    static func load() -> Set<SavedMovie> {
        guard
            let data = Self.fileData(),
            let movies = try? Self.decoder.decode(Set<SavedMovie>.self, from: data) else {
            return []
        }
        return movies
    }

    static func save(movies: Set<SavedMovie>) throws {
        let fileUrl = try Self.fileUrl()
        let data = try Self.encoder.encode(movies)
        try data.write(to: fileUrl)
    }
}
