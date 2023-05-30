//
//  MovieGridView.swift
//  Popcorn
//
//  Created by Rasmus Nielsen on 18/02/2023.
//

import SwiftUI

struct MovieGridView<T: MovieLike> {
    let movies: Array<T>
    let numberOfRows: Int
    let useEndText: Bool
}

extension MovieGridView: View {
    var body: some View {
        let spacing: CGFloat = 10
        let columns = Array(repeating: GridItem(.flexible(), spacing: spacing), count: numberOfRows)
        LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(self.movies) { movie in
                NavigationLink(destination: MovieDetailView(movieId: movie.id)){
                    MoviePosterCard(url: movie.artworkUrl)
                }
            }
        }
        .padding()
      if useEndText {
        EndMovieGrid()
      }
    }
}

struct EndMovieGrid : View {
  var body: some View {
    VStack(){
      Image("ic-theend")
        .resizable()
        .scaledToFit()
        .frame(width:100)
      Text("You have reached the end of our ever-changing collection. 20 movies, daily. Come back soon for additional titles!")
        .foregroundColor(Color("label"))
        .font(.custom("Outfit-Regular", size: 14))
        .multilineTextAlignment(.center)
        .padding()

    }
    .padding(.top, -100)
    .offset(y: 140)

  }
}
