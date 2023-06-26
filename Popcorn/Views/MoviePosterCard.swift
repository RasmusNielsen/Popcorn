//
//  MoviePosterCard.swift
//  Popcorn
//
//  Created by Rasmus Nielsen on 14/02/2023.
//

import SwiftUI

struct MoviePosterCard: View {
    let url: URL
    let borderRadius: CGFloat = 8;
  
    var body: some View {
        AsyncImage(url: self.url) { image in
            image.resizable().aspectRatio(contentMode: .fill)
        } placeholder: {
            Image("cover").resizable().scaledToFit()
        }
        .cornerRadius(self.borderRadius)
        .overlay {
          RoundedRectangle(cornerRadius: self.borderRadius)
              .stroke(.white.opacity(0.1), lineWidth: 1)
        }
    }
}

struct MoviePosterCard_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCard(url: Movie.stubbedMovie.posterURL)
    }
}
