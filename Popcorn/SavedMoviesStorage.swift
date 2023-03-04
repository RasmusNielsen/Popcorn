//
//  SavedMoviesStorage.swift
//  Popcorn
//
//  Created by Kasper Kronborg on 04/03/2023.
//

import Foundation

class SavedMoviesStorage {
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
    
    static public func get() -> Set<Int> {
        guard
            let data = Self.fileData(),
            let movieIds = try? Self.decoder.decode(Set<Int>.self, from: data) else {
            return Set<Int>()
        }
        return movieIds
    }
    
    static public func set(movieIds: Set<Int>) throws {
        let fileUrl = try Self.fileUrl()
        let data = try Self.encoder.encode(movieIds)
        try data.write(to: fileUrl)
    }
}
