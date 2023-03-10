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
            MovieGridView(movies: self.savedMovies.movies)
        }
        .navigationBarTitle("Saved Movies")
    }
}

struct SavedMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedMoviesView()
    }
}
