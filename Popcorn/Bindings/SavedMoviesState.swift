//
//  SavedMoviesState.swift
//  Popcorn
//
//  Created by Kasper Kronborg on 04/03/2023.
//

import Foundation
import Combine

class SavedMoviesState: ObservableObject {
    @Published public var movies: Array<SavedMovie> = []
    @Published private var storage: Set<SavedMovie> = Set(SavedMoviesDataStorage.load())
    
    public init() {
        self.$storage
            .map { Array($0) }
            .assign(to: &self.$movies)
    }
        
    public func save(movie: Movie) {
        let savedMovie = SavedMovie(id: movie.id, title: movie.title, saved: Date(), artworkUrl: movie.posterURL)
        self.storage.insert(savedMovie)
        // TODO: Better error handling if save should fail.
        try? SavedMoviesDataStorage.save(movies: Array(self.storage))
    }
    
    public func delete(movieId: Int) {
        if let idx = self.storage.firstIndex(where: { $0.id == movieId }) {
            self.storage.remove(at: idx)
            // TODO: Better error handling if save should fail.
            try? SavedMoviesDataStorage.save(movies: Array(self.storage))
        }
    }
    
    public func isSaved(movieId: Int) -> Bool {
        return self.storage.firstIndex { $0.id == movieId } != nil
    }
}
