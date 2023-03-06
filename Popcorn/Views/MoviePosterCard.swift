//
//  MoviePosterCard.swift
//  Popcorn
//
//  Created by Rasmus Nielsen on 14/02/2023.
//

import SwiftUI

struct MoviePosterCard: View {
  
  let borderRadius: CGFloat = 8;

  
  let url: URL
  @ObservedObject var imageLoader = ImageLoader()
  
  var body: some View {
    ZStack {
      if self.imageLoader.image != nil {
        Image(uiImage: self.imageLoader.image!)
          .resizable()
          .scaledToFit()
      } else {
        Image("cover")
          .resizable()
          .scaledToFit()
      }
    }.cornerRadius(borderRadius)
      .overlay(
              RoundedRectangle(cornerRadius: borderRadius)
                .stroke(.white.opacity(0.1), lineWidth: 1)
          )

    .onAppear {
        self.imageLoader.loadImage(with: self.url)
      }
  }
}

struct MoviePosterCard_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCard(url: Movie.stubbedMovie.posterURL)
    }
}
