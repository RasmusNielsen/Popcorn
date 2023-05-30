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
      NavigationStack {
        
        ScrollView(showsIndicators: false) {
          // check if movies saved
          if (self.movies.count == 0){
            VStack{
              Image("ic-save")
                .resizable()
                .scaledToFit()
                .frame(width:34, height: 34)
                .padding(.top, 30)
              Text("No movies here, yet. \n Use the other tabs to find something.")
                .foregroundColor(Color("label"))
                .font(.custom("Outfit-Regular", size: 16))
            }
            .multilineTextAlignment(.center)
            .padding()
          }
          MovieGridView(movies: self.movies.sorted(by: \.saved, using: >), numberOfRows: 4, useEndText: false)
        }
        
        .navigationBarTitle("Shelf")
        .onAppear {
            self.movies = self.savedMovies.movies
        }
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
