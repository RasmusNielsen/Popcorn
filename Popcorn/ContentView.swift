//
//  ContentView.swift
//  Popcorn
//
//  Created by Rasmus Nielsen on 12/02/2023.
//

import SwiftUI

struct ContentView: View {
  
  init() {
         //Use this if NavigationBarTitle is with Large Font
    let font = UIFont(name: "Outfit-SemiBold", size: 34)!
    
    let attributes: [NSAttributedString.Key: Any] = [
        .font: font,
        .kern: -1.0 // Set the kerning value here
    ]

    UINavigationBar.appearance().largeTitleTextAttributes = attributes
         //Use this if NavigationBarTitle is with displayMode = .inline
         UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Outfit-SemiBold", size: 20)!]
     }
  
  @ObservedObject private var nowPlayingStatePopular = MovieListState()
  @ObservedObject private var nowPlayingStateEssentials = MovieListState()
  @ObservedObject private var nowPlayingStateTrending = MovieListState()

  @State var selectedTab: Tabs = .popular
  
  @State private var showTabbar = true
  @State private var showingSearchSheet = false
  
  @StateObject private var savedMovies = SavedMoviesState()
    
    var body: some View {
        ZStack {
            NavigationStack {
                // TAB POPULAR
                if selectedTab == .popular {
                    ScrollView(showsIndicators: false) {
                        if nowPlayingStatePopular.movies != nil {
                            MovieGridView(movies: nowPlayingStatePopular.movies!, numberOfRows: 2, useEndText: true)
                        }
                    }
                    .refreshable {
                        self.nowPlayingStatePopular.loadMovies(with: .popular)
                    }
                    .navigationBarTitle("Popular")
                      .toolbar {
                      HStack{
                        Button {
                          showingSearchSheet.toggle()
                        } label: {
                          Image("ic-search")
                            .resizable()
                            .scaledToFit()
                            .frame(width:34, height: 34)
                        }
                        .sheet(isPresented: $showingSearchSheet) {
                          MovieSearchView()
                        }
                        Button {
                          showingSearchSheet.toggle()
                        } label: {
                          Image("ic-settings")
                            .resizable()
                            .scaledToFit()
                            .frame(width:34, height: 34)
                        }
                        .sheet(isPresented: $showingSearchSheet) {
                          MovieSearchView()
                        }
                      }
                    }
                }
                // TAB POPULAR
                
                // TAB ESSENTIALS
                if selectedTab == .essentials {
                    ScrollView(showsIndicators: false) {
                        if nowPlayingStateEssentials.movies != nil {
                            MovieGridView(movies: nowPlayingStateEssentials.movies!, numberOfRows: 2, useEndText: true)
                        }
                    }
                    .refreshable {
                        self.nowPlayingStateEssentials.loadMovies(with: .upcoming)
                    }
                    .navigationBarTitle("Upcoming")
                  
                }
                // TAB ESSENTIALS
                
                // TAB TRENDING
                if selectedTab == .trending {
                    BrowseView()
                }
                // TAB ESSENTIALS
                
                // SEARCH
                if selectedTab == .search {
                  SavedMoviesView()
                    //MovieSearchView()
                    //MovieSearchView()
                }
                // SEARCH
            }
            .environment(\.colorScheme, .dark)
            .onAppear{self.nowPlayingStatePopular.loadMovies(with: .popular)}
            .onAppear{self.nowPlayingStateEssentials.loadMovies(with: .upcoming)}
            .onAppear{self.nowPlayingStateTrending.loadTrendingMovies(with: .trending)}

            VStack {
                Spacer()
                if (showTabbar) { CustomTabbar(selectedTab: $selectedTab) }
            }
        }
        .preferredColorScheme(.dark)
        .environmentObject(self.savedMovies)
    }
}
