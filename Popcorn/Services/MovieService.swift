//
//  MovieService.swift
//  Popcorn
//
//  Created by Rasmus Nielsen on 14/02/2023.
//

import Foundation

protocol MovieService {
  
  func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
  func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ())
  func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
  
  //Experiment
  func fetchTrendingMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
  //Experiment
  
  //Discovery
  func fetchDiscoveryMovies(query: String, sort: String, from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
  //Discovery
  

}

enum MovieListEndpoint: String, CaseIterable, Identifiable {
    
    var id: String { rawValue }
    
    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular
    case trending = ""
    //case discover = "&sort_by=popularity.asc"
  
    var description: String {
        switch self {
            case .nowPlaying: return "Now Playing"
            case .upcoming: return "Upcoming"
            case .topRated: return "Top Rated"
            case .popular: return "Popular"
            case .trending: return "Trending"
            //case .discover: return ""

        }
    }
}

enum MovieError: Error, CustomNSError {
    
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
    
}
