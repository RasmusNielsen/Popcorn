//
//  SavedMovie.swift
//  Popcorn
//
//  Created by Kasper Kronborg on 06/03/2023.
//

import Foundation

struct SavedMovie {
    let id: Int
    let title: String
    let saved: Date
    let artworkUrl: URL
}

extension SavedMovie: Encodable {}
extension SavedMovie: Decodable {}

extension SavedMovie: Hashable {
    static func == (lhs: SavedMovie, rhs: SavedMovie) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

extension SavedMovie: MovieLike {}
