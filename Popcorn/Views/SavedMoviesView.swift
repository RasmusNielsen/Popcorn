//
//  SavedMoviesView.swift
//  Popcorn
//
//  Created by Kasper Kronborg on 06/03/2023.
//

import SwiftUI

struct SavedMoviesView: View {
    @EnvironmentObject private var savedMovies: SavedMoviesState
    @State private var movies: Set<SavedMovie> = []
    
    var body: some View {
        ScrollView(showsIndicators: false) {
          // check if movies saved
          if (self.movies.count == 0){}
            MovieGridView(movies: self.movies.sorted(by: \.saved, using: >), numberOfRows: 4)
        }
        .navigationBarTitle("Saved")
        .onAppear {
            self.movies = self.savedMovies.movies
        }
    }
}

struct SavedMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedMoviesView()
    }
}

extension Sequence {
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>, using comparator: (T, T) -> Bool = (<)) -> [Element] {
        return self.sorted { a, b in
            comparator(a[keyPath: keyPath], b[keyPath: keyPath])
        }
    }
}
