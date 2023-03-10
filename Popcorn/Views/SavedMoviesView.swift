//
//  SavedMoviesView.swift
//  Popcorn
//
//  Created by Kasper Kronborg on 06/03/2023.
//

import SwiftUI

struct SavedMoviesView: View {
    @EnvironmentObject private var savedMovies: SavedMoviesState
    var body: some View {
        ScrollView(showsIndicators: false) {
          // check if movies saved
          if (self.savedMovies.movies.count == 0){}
          MovieGridView(movies: self.savedMovies.movies, numberOfRows: 4)
        }
        .navigationBarTitle("Saved")
    }
}

struct SavedMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedMoviesView()
    }
}
