//
//  SavedMoviesState.swift
//  Popcorn
//
//  Created by Kasper Kronborg on 04/03/2023.
//

import Foundation
import Combine

final class SavedMoviesState: ObservableObject {
    @Published var movies: Set<SavedMovie> = SavedMoviesDataStorage.load()
        
    func save(movie: Movie) {
        let savedMovie = SavedMovie(id: movie.id, title: movie.title, saved: Date(), artworkUrl: movie.posterURL)
        self.movies.insert(savedMovie)
        // TODO: Better error handling if save should fail.
        try? SavedMoviesDataStorage.save(movies: self.movies)
    }
    
    func delete(movieId: Int) {
        if let idx = self.movies.firstIndex(where: { $0.id == movieId }) {
            self.movies.remove(at: idx)
            // TODO: Better error handling if save should fail.
            try? SavedMoviesDataStorage.save(movies: self.movies)
        }
    }
    
    func isSaved(movieId: Int) -> Bool {
        return self.movies.firstIndex { $0.id == movieId } != nil
    }
}
