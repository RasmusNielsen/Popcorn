//
//  PopularView.swift
//  Popcorn
//
//  Created by Rasmus Nielsen on 22/05/2023.
//

import SwiftUI

struct PopularView: View {
  
  @ObservedObject private var nowPlayingStatePopular = MovieListState()

  var body: some View {
    NavigationStack {
        if nowPlayingStatePopular.movies != nil {
          MovieGridView(movies: nowPlayingStatePopular.movies!, numberOfRows: 2, useEndText: false, navTitle: "Popular")
        }
      
    } .navigationBarTitle("Popular")
      .onAppear{self.nowPlayingStatePopular.loadMovies(with: .popular)}
  }
}

struct PopularView_Previews: PreviewProvider {
    static var previews: some View {
        PopularView()
    }
}
