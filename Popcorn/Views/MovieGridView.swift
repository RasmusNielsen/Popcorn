//
//  MovieGridView.swift
//  Popcorn
//
//  Created by Rasmus Nielsen on 18/02/2023.
//

import SwiftUI

struct MovieGridView {
    let movies: [Movie]
}

extension MovieGridView: View {
    var body: some View {
        let spacing: CGFloat = 10
        let numberOfRows: Int = 2
        let columns = Array(repeating: GridItem(.flexible(), spacing: spacing), count: numberOfRows)
        LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(self.movies) { movie in
                NavigationLink(destination: MovieDetailView(movieId: movie.id)){
                    MoviePosterCard(url: movie.posterURL)
                }
            }
        }
        .padding()
        Spacer().frame(height: 70)
    }
  
}
