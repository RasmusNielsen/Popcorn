//
//  MovieSearchView.swift
//  Popcorn
//
//  Created by Rasmus Nielsen on 23/02/2023.
//

import SwiftUI

struct MovieSearchView: View {
    
    @ObservedObject var movieSearchState = MovieSearchState()
    
    var body: some View {
      
      let spacing: CGFloat = 10
      let columns = Array(repeating: GridItem(.flexible(), spacing: spacing), count: 2)
    
      
      NavigationStack {
        ScrollView(showsIndicators: false) {
                SearchBarView(placeholder: "Search movies", text: self.$movieSearchState.query)
                    .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                
                LoadingView(isLoading: self.movieSearchState.isLoading, error: self.movieSearchState.error) {
                    self.movieSearchState.search(query: self.movieSearchState.query)
                }
                
                if self.movieSearchState.movies != nil {
                  LazyVGrid(columns: columns, spacing: spacing) {
             
                    ForEach(self.movieSearchState.movies!) { movie in
                      NavigationLink(destination: MovieDetailView(movieId: movie.id)){
                          MoviePosterCard(url: movie.artworkUrl)
                      }
                    }
                    }
                }
                
            }
            .onAppear {
                self.movieSearchState.startObserve()
            }
            .navigationBarTitle("Search")
          
        }
    }
}
