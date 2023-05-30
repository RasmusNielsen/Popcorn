//
//  UpcomingView.swift
//  Popcorn
//
//  Created by Rasmus Nielsen on 22/05/2023.
//

import SwiftUI

struct UpcomingView: View {
  
  @ObservedObject private var nowPlayingStateEssentials = MovieListState()
  
    var body: some View {
      NavigationStack {
        ScrollView(showsIndicators: false) {
          if nowPlayingStateEssentials.movies != nil {
            MovieGridView(movies: nowPlayingStateEssentials.movies!, numberOfRows: 2, useEndText: true)
          }
        }
        .navigationBarTitle("Upcoming")
        .onAppear{self.nowPlayingStateEssentials.loadMovies(with: .upcoming)}
      }
      

    }
}

struct UpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingView()
    }
}
