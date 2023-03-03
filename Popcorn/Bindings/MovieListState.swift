//
//  MovieListState.swift
//  Popcorn
//
//  Created by Rasmus Nielsen on 14/02/2023.
//

import SwiftUI

class MovieListState: ObservableObject {
    
    @Published var movies: [Movie]?
    @Published var isLoading: Bool = false
    @Published var error: NSError?

    private let movieService: MovieService
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func loadMovies(with endpoint: MovieListEndpoint) {
        self.movies = nil
        self.isLoading = true
        self.movieService.fetchMovies(from: endpoint) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movies = response.results
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
  
  // EXPERIMENT
  func loadTrendingMovies(with endpoint: MovieListEndpoint) {
      self.movies = nil
      self.isLoading = true
      self.movieService.fetchTrendingMovies(from: endpoint) { [weak self] (result) in
      guard let self = self else { return }
      self.isLoading = false
        switch result {
        case .success (let response):
          self.movies = response.results
        case .failure(let error):
          self.error = error as NSError
        }
      
    }
  }
  // EXPERIMENT

  // EXPERIMENT
  func loadDiscoveryMovies(query: String, sort: String, with endpoint: MovieListEndpoint) {
      self.movies = nil
      self.isLoading = true
    self.movieService.fetchDiscoveryMovies(query: query, sort: sort, from: endpoint) { [weak self] (result) in
      guard let self = self else { return }
      self.isLoading = false
        switch result {
        case .success (let response):
          self.movies = response.results
        case .failure(let error):
          self.error = error as NSError
        }
      
    }
  }
  // EXPERIMENT
  
    
}
