//
//  SplashScreenView.swift
//  Popcorn
//
//  Created by Rasmus Nielsen on 19/02/2023.
//

import SwiftUI

import SwiftUI

struct SplashScreenView: View {
    @State var isActive : Bool = false
    @State private var size = 0.2
  @State private var opacity = 0.0
    
    // Customise your SplashScreen here
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
      
                    Image("ic-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                  withAnimation(.interpolatingSpring(stiffness: 200, damping: 8)) {
                        self.size = 1.2
                        self.opacity = 1.00
                    }
                }
            }.preferredColorScheme(.dark)
            .onAppear {
              DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation() {
                        self.isActive = true
                    }
                }
            }

          
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
