//
//  TabbarButton.swift
//  Popcorn
//
//  Created by Rasmus Nielsen on 13/02/2023.
//

import SwiftUI

struct TabbarButton: View {
  
  let spacing: CGFloat = 0;
  let tabwidth: CGFloat = 82;

  var buttonText: String
  var imageName: String
  var isActive: Bool
  
    var body: some View {

      ZStack{
        if isActive{
        Image("ribbon")
          .resizable()
          .scaledToFit()
          .frame(width: tabwidth)
          .offset(y: -4)
          .ignoresSafeArea()
        }
      VStack(spacing: -1){
        Image(imageName)
          .resizable()
          .scaledToFit()
          .frame(width:34, height: 34)
        Text(buttonText)
          .foregroundColor(Color("label"))
          .font(.custom("Outfit-Regular", size: 13))

      }.offset(y: -2).frame(width: tabwidth).padding(EdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing))
    }
    }
}

struct TabbarButton_Previews: PreviewProvider {
    static var previews: some View {
        TabbarButton(buttonText: "Chat", imageName: "ic-eye", isActive: true)
    }
}
