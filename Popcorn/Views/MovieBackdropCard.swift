//
//  MovieBackdropCard.swift
//  Popcorn
//
//  Created by Rasmus Nielsen on 14/02/2023.
//

import SwiftUI

struct MovieBackdropCard: View {
    
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    @ObservedObject var imageLoader2 = ImageLoader()

    var body: some View {
        VStack(alignment: .leading) {
          ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.black.opacity(1))
              
 
                
                if self.imageLoader.image != nil {
                    Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .opacity(0.5)
                }
              
              if self.imageLoader2.image != nil {
                  Image(uiImage: self.imageLoader2.image!)
                  .resizable()
                  .zIndex(1)
                  .scaledToFit()
                  .cornerRadius(4)
                  .overlay(
                          RoundedRectangle(cornerRadius: 4)
                            .stroke(.white.opacity(0.1), lineWidth: 1)
                      )
                  .padding()
                
              }
              
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(8)
              .overlay(
                      RoundedRectangle(cornerRadius: 8)
                        .stroke(.white.opacity(0.1), lineWidth: 1)
                  )
          Text(movie.title).font(Font.custom("Outfit-Regular", size: 16)).foregroundColor(.white)

        }
        .lineLimit(1)
        .onAppear {
            self.imageLoader.loadImage(with: self.movie.backdropSmallURL)
            self.imageLoader2.loadImage(with: self.movie.posterURL)

        }
    }
}

struct MovieBackdropCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackdropCard(movie: Movie.stubbedMovie)
    }
}
