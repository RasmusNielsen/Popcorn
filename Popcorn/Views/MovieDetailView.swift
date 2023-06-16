//
//  MovieDetailView.swift
//  Popcorn
//
//  Created by Rasmus Nielsen on 19/02/2023.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movieId: Int
    @ObservedObject private var movieDetailState = MovieDetailState()
  
  
    var body: some View {
        ZStack {
            LoadingView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error) {
                self.movieDetailState.loadMovie(id: self.movieId)
            }
            
            if movieDetailState.movie != nil {
                MovieDetailListView(movie: self.movieDetailState.movie!)
            }
        }
        .preferredColorScheme(.dark)
        .navigationBarHidden(true)
        .onAppear {
            self.movieDetailState.loadMovie(id: self.movieId)
        }
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
  override open func viewDidLoad() {
      super.viewDidLoad()
      interactivePopGestureRecognizer?.delegate = self
  }
  
public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
  return true
  }
}

struct TestView: View {
  var body: some View {
    Image("cover")
  }
}



struct MovieDetailListView: View {
  
 
  let movie: Movie
  @State private var selectedTrailer: MovieVideo?
  @EnvironmentObject private var savedMovies: SavedMoviesState
  
  @Environment(\.presentationMode) var presentationMode
  
  let imageLoader = ImageLoader()
  let imageLoader2 = ImageLoader()


  var shareMoviePosterView = TestView()

  var body: some View {
    let isSaved = self.savedMovies.isSaved(movieId: self.movie.id)
    ScrollView(showsIndicators: false){
      VStack{
        let height = 900 * 0.45
        GeometryReader{ proxy in
          
          let size = proxy.size
          let minY = proxy.frame(in: .named("SCROLL")).minY
          let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            MovieDetailImage(imageLoader: imageLoader, imageURL: self.movie.backdropURL)
            .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0 ))
            .clipped()
            .overlay(content: {
              ZStack(alignment: .bottom) {
                // MARK: - Gradient Overlay
                Rectangle()
                  .fill(
                    .linearGradient(colors: [
                      .black.opacity(0 - progress),
                      .black.opacity(0.1 - progress),
                      .black.opacity(0.3 - progress),
                      .black.opacity(0.5 - progress),
                      .black.opacity(0.8 - progress),
                      .black.opacity(1),
                    ], startPoint: .top, endPoint: .bottom)
                  )
                VStack(spacing: 0) {
                  HStack{
                    MoviePosterImage(imageLoader: imageLoader2, imageURL: self.movie.posterURL)
                      .padding()
                    VStack{
                      HStack{
                        Text(movie.title)
                          .lineLimit(3)
                          .font(Font.custom("Outfit-SemiBold", size: 32))
                        Spacer()
                      }
                      HStack{
                        Text(movie.yearText)
                        Text(" ")
                        Text(movie.ratingText).foregroundColor(Color("gold"))
                        Text(movie.scoreText)
              
                        Spacer()
                      }
                    }
                  }
                }
                .opacity(1 + (progress > 0 ? -progress : progress))
                .padding(.bottom, 0)
                
                // Moving with Scroll View
                .offset(y: minY < 0 ? minY : 0 )

              }
            })
            .offset(y: -minY)
        }.padding(.top, -34)
        
        .frame(height: height)
        HStack{
            Button {
            self.presentationMode.wrappedValue.dismiss()
             
            
                
          } label: {
            Image("ic-back")
              .resizable()
              .scaledToFit()
              .frame(width:34, height: 34)
          }
          .tint(Color.white.opacity(0.1))
          .buttonStyle(.borderedProminent)
          .overlay(
            RoundedRectangle(cornerRadius: 10)
              .stroke(Color.white.opacity(0.1), lineWidth: 1)
          )

          Button {
            isSaved ? self.savedMovies.delete(movieId: self.movie.id) : self.savedMovies.save(movie: self.movie)
          } label: {
            Spacer()
            Image(isSaved ? "ic-saved" : "ic-save")
              .resizable()
              .scaledToFit()
              .frame(width:34, height: 34)
            Text("Add to collection")
            Spacer()
          }
          .tint(Color.white.opacity(0.1))
          .buttonStyle(.borderedProminent)
          .overlay(
            RoundedRectangle(cornerRadius: 10)
              .stroke(Color.white.opacity(0.1), lineWidth: 1)
          )
       
          //ShareLink(item: Image(uiImage: image()), preview:SharePreview(movie.title, image: Image(uiImage:image()))){}
       
          Button {
          //self.presentationMode.wrappedValue.dismiss()
            let chartView = ShareMoviePosterImage(imageLoader: imageLoader2, imageURL: self.movie.posterURL)
            let renderer = ImageRenderer(content: chartView)
            renderer.scale = UIScreen.main.scale
            let image = renderer.uiImage
            
            let avController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(avController, animated: true, completion: nil)
              
            //if let image = renderer.uiImage { UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)}
              //
              
        } label: {
          Image("ic-share")
            .resizable()
            .scaledToFit()
            .frame(width:34, height: 34)
        }
        .tint(Color.white.opacity(0.1))
        .buttonStyle(.borderedProminent)
        .overlay(
          RoundedRectangle(cornerRadius: 10)
            .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
//
//          ShareLink(item: Image(uiImage: generateSnapshot()), preview:SharePreview(movie.title, image: Image(uiImage:generateSnapshot()))){
//
//            HStack{
//              Image("ic-share")
//                .resizable()
//                .scaledToFit()
//                .frame(width:34, height: 34)
//                .padding(7)
//            }
//
//            .background(Color.white.opacity(0.1))
//            .cornerRadius(10)
//            .overlay(
//              RoundedRectangle(cornerRadius: 10)
//                .stroke(Color.white.opacity(0.1), lineWidth: 1)
//            )
//          }
          
          
        }.padding()
        
        HStack {
          Text(movie.genreText)
          Text("·")
          Text(movie.yearText)
          Text(movie.durationText)
          Spacer()
        }.padding(.leading, 20) .font(Font.custom("Outfit-Regular", size: 16))
        
        //Link(movie.imdb_id ?? " ", destination: URL(string: "https://www.imdb.com/\(movie.imdb_id)")!) // 1
         
        
        Text(movie.overview)
          .font(Font.custom("Outfit-Regular", size: 16))
          .lineSpacing(5)
          .padding()
        
        
        HStack(alignment: .top, spacing: 4) {
          if movie.cast != nil && movie.cast!.count > 0 {
            VStack(alignment: .leading, spacing: 4) {
              Text("Starring").font(Font.custom("Outfit-Regular", size: 16)).foregroundColor(Color("gold"))
              ForEach(self.movie.cast!.prefix(9)) { cast in
                Text(cast.name)
              }
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Spacer()
            
          }
          
          if movie.crew != nil && movie.crew!.count > 0 {
            VStack(alignment: .leading, spacing: 4) {
              if movie.directors != nil && movie.directors!.count > 0 {
                Text("Director(s)").font(Font.custom("Outfit-Regular", size: 16)).foregroundColor(Color("gold"))
                ForEach(self.movie.directors!.prefix(2)) { crew in
                  Text(crew.name)
                }
              }
              
              if movie.producers != nil && movie.producers!.count > 0 {
                Text("Producer(s)").font(Font.custom("Outfit-Regular", size: 16)).foregroundColor(Color("gold"))
                  .padding(.top)
                ForEach(self.movie.producers!.prefix(2)) { crew in
                  Text(crew.name)
                }
              }
              
              if movie.screenWriters != nil && movie.screenWriters!.count > 0 {
                Text("Screenwriter(s)").font(Font.custom("Outfit-Regular", size: 16)).foregroundColor(Color("gold"))
                  .padding(.top)
                ForEach(self.movie.screenWriters!.prefix(2)) { crew in
                  Text(crew.name)
                }
              }
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
          }
        }.padding()
        
        
        
        if movie.youtubeTrailers != nil && movie.youtubeTrailers!.count > 0 {
          HStack() {
            Text("Trailers").font(Font.custom("Outfit-Regular", size: 16)).foregroundColor(Color("gold")).padding()
            Spacer()
          }
          ScrollView(.horizontal) {
              HStack(spacing: 0) {
                  // Add views to be horizontally scrolled here
                
                ForEach(movie.youtubeTrailers!) { trailer in
                  Button(action: {
                    self.selectedTrailer = trailer
                  }) {
                      AsyncImage(url: trailer.youtubeImageURL!) { image in
                        image
                          .resizable()
                          .scaledToFit()
                          .cornerRadius(8)
                          .frame(width: 300)
                        
                          .overlay(
                            RoundedRectangle(cornerRadius: 8)
                              .stroke(.white.opacity(0.1), lineWidth: 1)
                          )
                          .padding(.horizontal)
                        
                      } placeholder: {}
                    
                  }
                }
              }
          }.scrollIndicators(.hidden)
            .sheet(item: self.$selectedTrailer) { trailer in
              SafariView(url: trailer.youtubeURL!)
            }
          
          HStack() {
            Text("Reviews").font(Font.custom("Outfit-Regular", size: 16)).foregroundColor(Color("gold")).padding()
            Spacer()
          }
          
          VStack{
                 if movie.userreviews != nil {
              ForEach(movie.userreviews!) { reviews in
                Text(reviews.content).padding()
                Image("sep").resizable().scaledToFit()

                
              }
                 }
        
          }
          
        }

            
          }
          
      
      Spacer().frame(height: 100)

      
    }.font(Font.custom("Outfit-Regular", size: 16))
  }
}

struct MovieDetailImage: View {
    @ObservedObject var imageLoader: ImageLoader
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.black.opacity(0.3))
          if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .opacity(1)
            }
          Rectangle()                         // Shapes are resizable by default
                 .foregroundColor(.clear)        // Making rectangle transparent
                 .background(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom))
          
       }
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}

// Trailer

struct MovieTrailerView: View {
    @ObservedObject var imageLoader: ImageLoader
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.black.opacity(0.3))
          if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
              .scaledToFit()
              .cornerRadius(8)
            }
       }
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}

// Trailer

struct MoviePosterImage: View {
    @ObservedObject var imageLoader: ImageLoader
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
          if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
            }
          
        }
        .frame(width: 100, height: 150)
        .cornerRadius(8)
        
        .overlay(
                RoundedRectangle(cornerRadius: 8)
                  .stroke(.white.opacity(0.1), lineWidth: 1)
            )
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}


struct ShareMoviePosterImage: View {
    @ObservedObject var imageLoader: ImageLoader
    let imageURL: URL
    
    var body: some View {
        ZStack {
          //Background Image
          if self.imageLoader.image != nil {Image(uiImage: self.imageLoader.image!)
              .resizable()
              .frame(width: 800, height: 800)
              .aspectRatio(contentMode: .fit)
              .opacity(0.15)
          }
          
          if self.imageLoader.image != nil {Image(uiImage: self.imageLoader.image!)
              .resizable()
              .frame(width: 400, height: 600)
              .cornerRadius(30)
              .overlay(
                      RoundedRectangle(cornerRadius: 30)
                        .stroke(.white.opacity(0.1), lineWidth: 1)
                  )
          }
          
        }
        .frame(width: 800, height: 800)
        .background(Color.black)
       
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}



struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetailView(movieId: Movie.stubbedMovie.id)
        }
    }
}
