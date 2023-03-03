//
//  MovieGridView.swift
//  Popcorn
//
//  Created by Rasmus Nielsen on 18/02/2023.
//

import SwiftUI

struct MovieGridView: View {
  
  let spacing: CGFloat = 10;
  let title: String
  let movies: [Movie]
  
  @State var numberOfRows = 2
  

  var body: some View {
    
    let columns = Array (
      repeating: GridItem(.flexible(), spacing: spacing),
      count: numberOfRows)
    
      LazyVGrid(columns: columns, spacing: spacing) {
        ForEach(self.movies) { movie in
          NavigationLink(destination: MovieDetailView(movieId: movie.id)){
            MoviePosterCard(movie: movie)
          }
        }
      }.padding()
      
      Spacer().frame(height: 70)
      
    }
  
}
