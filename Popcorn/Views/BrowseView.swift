//
//  BrowseView.swift
//  Popcorn
//
//  Created by Rasmus Nielsen on 24/02/2023.
//

import SwiftUI

struct BrowseView: View {

  @ObservedObject private var nowPlayingStateTrending = MovieListState()
  @ObservedObject private var genreAdventureState = MovieListState()
  @ObservedObject private var genreActioneState = MovieListState()
  @ObservedObject private var genreSciFiState = MovieListState()
  @ObservedObject private var genreHistoryState = MovieListState()
  @ObservedObject private var genreAnimationState = MovieListState()
  @ObservedObject private var nowPlayingStatePopular = MovieListState()

  
  var body: some View {
      ScrollView{
        VStack{
          
          HeaderSubView(title: "Trending")
          if nowPlayingStateTrending.movies != nil {
            MovieBackdropCarouselView(title: "", movies: nowPlayingStateTrending.movies!)
          }
              
          HeaderSubView(title: "Adrenaline Odyssey")
          
          if genreAdventureState.movies != nil {
            MovieBackdropCarouselView(title: "", movies: genreAdventureState.movies!)
          } else {
            LoadingView(isLoading: self.genreAdventureState.isLoading, error: self.genreAdventureState.error) {
              self.genreAdventureState.loadMovies(with: .nowPlaying)
            }
          }
          // Adventure

          HeaderSubView(title: "Essentials")
          
          if nowPlayingStatePopular.movies != nil {
            MovieBackdropCarouselView(title: "", movies: nowPlayingStatePopular.movies!)
          }
          
            
          
          // Action
          HeaderSubView(title: "Heartfelt Harmony")
          
          if genreActioneState.movies != nil {
            MovieBackdropCarouselView(title: "", movies: genreActioneState.movies!)
          } else {
            LoadingView(isLoading: self.genreActioneState.isLoading, error: self.genreActioneState.error) {
              self.genreActioneState.loadMovies(with: .nowPlaying)
            }
          }
         
          // Action
          
          // Sci-Fi
          HeaderSubView(title: "Science Fiction")
          if genreSciFiState.movies != nil {
            MovieBackdropCarouselView(title: "", movies: genreSciFiState.movies!)
          } else {
            LoadingView(isLoading: self.genreSciFiState.isLoading, error: self.genreSciFiState.error) {
              self.genreSciFiState.loadDiscoveryMovies(query: "878",  sort:"", with: .trending)
            }
          }
          // Sci-Fi
                    
        }
      }.navigationBarTitle("Browse")
    
         .onAppear {
           self.genreAdventureState.loadDiscoveryMovies(query: "36, 28",  sort:"popularity.desc", with: .trending)
           self.genreActioneState.loadDiscoveryMovies(query: "35, 10751, 10749, 18",  sort:"popularity.desc", with: .trending)
           self.genreSciFiState.loadDiscoveryMovies(query: "878, 18",  sort:"popularity.desc", with: .trending)
           self.genreHistoryState.loadDiscoveryMovies(query: "36",  sort:"popularity.desc", with: .trending)
           self.genreAnimationState.loadDiscoveryMovies(query: "16",  sort:"popularity.desc", with: .trending)
           self.nowPlayingStateTrending.loadTrendingMovies(with: .trending)
           self.nowPlayingStatePopular.loadMovies(with: .topRated)

         }
         
     }
 }
