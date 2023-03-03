//
//  CustomTabbar.swift
//  Popcorn
//
//  Created by Rasmus Nielsen on 12/02/2023.
//

import SwiftUI

enum Tabs: Int {
  case popular = 0
  case essentials = 1
  case trending = 2
  case search = 3
}

struct CustomTabbar: View {
  
  @Binding var selectedTab: Tabs
  let impactLight = UIImpactFeedbackGenerator(style: .light)
  
    var body: some View {
      HStack{
        Spacer()
        Button(){
          selectedTab = .popular
          impactLight.impactOccurred()          
        } label: {
          TabbarButton(buttonText: "Popular", imageName: "ic-star", isActive:  selectedTab == .popular)

        }
        Button(){
          selectedTab = .essentials
          impactLight.impactOccurred()
        } label: {
          TabbarButton(buttonText: "Upcoming", imageName: "ic-trending", isActive:  selectedTab == .essentials)
        }
        
        Button(){
          selectedTab = .trending
          impactLight.impactOccurred()
        } label: {
          TabbarButton(buttonText: "Browse", imageName: "ic-eye", isActive:  selectedTab == .trending)
        }
        
        Button(){
          selectedTab = .search
          impactLight.impactOccurred()
        } label: {
          TabbarButton(buttonText: "Search", imageName: "ic-search", isActive:  selectedTab == .search)
        }
        Spacer()
      }
      .frame(height:60)
      .background(.thickMaterial)
      .environment(\.colorScheme, .dark)
    }
}

struct CustomTabbar_Previews: PreviewProvider {
    static var previews: some View {
      CustomTabbar(selectedTab: .constant(.popular))
    }
}
