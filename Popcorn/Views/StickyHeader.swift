//
//  StickyHeader.swift
//  Popcorn
//
//  Created by Rasmus Nielsen on 21/02/2023.
//
//

import SwiftUI

struct StickyHeader: View {

  let movieId: Int
  
  @ObservedObject private var movieDetailState = MovieDetailState()

    // MARK: - Properties
    let safeArea: EdgeInsets
    let size: CGSize
  
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
              Artwork()
              MovieDetailView(movieId: movieId)
            }
        }
        .coordinateSpace(name: "SCROLL")
    }
    
    @ViewBuilder
    func Artwork() -> some View {
        let height = size.height * 0.45
        GeometryReader{ proxy in

            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            
            Image("backdrop")
                .resizable()
                .aspectRatio(contentMode: .fill)
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
                            Text("Ant Man")
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                        }
                        .opacity(1 + (progress > 0 ? -progress : progress))
                        .padding(.bottom, 55)
                        
                        // Moving with Scroll View
                        
                        .offset(y: minY < 0 ? minY : 0 )
                    }
                })
                .offset(y: -minY)
            }
        .frame(height: height + safeArea.top )
    }
 }

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
