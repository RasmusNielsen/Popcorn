//
//  HeaderSubView.swift
//  Popcorn
//
//  Created by Rasmus Nielsen on 25/02/2023.
//

import SwiftUI


struct HeaderSubView: View {
  let title: String

    var body: some View {
      HStack{
        Text(title).font(Font.custom("Outfit-Regular", size: 22)).foregroundColor(Color("gold")).padding()
        Spacer()
      }
    }
}

struct HeaderSubView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderSubView(title: "Hello")
    }
}
