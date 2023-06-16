//
//  MainView.swift
//  Popcorn
//
//  Created by Rasmus Nielsen on 22/05/2023.
//

import SwiftUI

struct MainView: View {
  
  var tabItems = TabItem.allCases
  @State var selected: TabItem = .popular
  
  init() {
    
    UITabBar.appearance().isHidden = true
    
    //UITabBar.appearance().isHidden = true
    let font = UIFont(name: "Outfit-SemiBold", size: 34)!
    
    let attributes: [NSAttributedString.Key: Any] = [
        .font: font,
        .kern: -1.0 // Set the kerning value here
    ]

      UINavigationBar.appearance().largeTitleTextAttributes = attributes
      UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Outfit-SemiBold", size: 20)!]
    }
  
  @StateObject private var savedMovies = SavedMoviesState()

  var body: some View {
    
    VStack(spacing: 0){
      TabView(selection: $selected){        
        PopularView()
          .tag(tabItems[0])
          .ignoresSafeArea(.all)
        
        UpcomingView()
          .tag(tabItems[1])
          .ignoresSafeArea(.all)
        
        MovieSearchView()
          .tag(tabItems[2])
          .ignoresSafeArea(.all)
        
        SavedMoviesView()
          .tag(tabItems[3])
          .ignoresSafeArea(.all)
      }
      Spacer(minLength: 0)
      CustomTabbarView(tabItems: tabItems, selected: $selected)
    }
    .preferredColorScheme(.dark)
    .environmentObject(self.savedMovies)
    .ignoresSafeArea(.all, edges: .bottom)
  }
}

extension UIApplication {
    static var safeAreaInsets: UIEdgeInsets  {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return scene?.windows.first?.safeAreaInsets ?? .zero
    }
}

enum TabItem: String, CaseIterable {
    case popular
    case upcoming
    case search
    case storage
      
    var description: String {
        switch self {
        case .popular:
            return "Popular"
        case .upcoming:
            return "Upcoming"
        case .search:
            return "Search"
        case .storage:
            return "Shelf"
        }
    }
    
    var icon: String {
        switch self {
        case .popular:
            return "ic-star"
            
        case .upcoming:
            return "ic-trending"
            
        case .search:
            return "ic-search"
            
        case .storage:
            return "ic-save"
        }
    }
}

struct CustomTabbarView: View {
  
    var tabItems: [TabItem]
    @State var centerX : CGFloat = 0
    @Environment(\.verticalSizeClass) var size
    @Binding var selected: TabItem
  
  @Namespace private var animation

    
    init(tabItems: [TabItem], selected: Binding<TabItem>) {
        UITabBar.appearance().isHidden = true
        self.tabItems = tabItems
        self._selected = selected
    }
    
    var body: some View {
    
        
        HStack(spacing: 0){
          
          ForEach(tabItems,id: \.self){value in
              GeometryReader{ proxy in
                BarButton(selected: $selected, centerX: $centerX, rect: proxy.frame(in: .global), value: value, animation: animation)
                  .onAppear(perform: {
                    if value == tabItems.first{
                      centerX = proxy.frame(in: .global).midX
                    }
                  })
                  .onChange(of: size) { (_) in
                    if selected == value{
                      centerX = proxy.frame(in: .global).midX
                    }
                  }
              }
              .frame(width: 70, height: 50)
              if value != tabItems.last{Spacer(minLength: 0)}
           }
          
        }
        .padding(.horizontal,25)
        .padding(.bottom,UIApplication.safeAreaInsets.bottom == 0 ? 15 : UIApplication.safeAreaInsets.bottom)
        .background(.ultraThinMaterial)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)
        .padding(.top,-15)
        .ignoresSafeArea(.all, edges: .horizontal)
        .frame(height:60)
      }
    
}


struct BarButton : View {
    @Binding var selected : TabItem
    @Binding var centerX : CGFloat
    
    let impactLight = UIImpactFeedbackGenerator(style: .light)

    var rect : CGRect
    var value: TabItem
    
    var animation : Namespace.ID
    
    var body: some View{
        Button(action: {
            withAnimation(.interpolatingSpring(stiffness: 2000, damping: 70)){
                selected = value
                centerX = rect.midX
                impactLight.impactOccurred()
            }
        }, label: {
  
          ZStack{
            if (selected == value){
              Image("ribbon")
                .resizable()
                .scaledToFit()
                .frame(width: 75)
                .offset(x: 0, y: -13)
                .ignoresSafeArea()
                .matchedGeometryEffect(id: "ribbon", in: animation)
            }
            
            VStack(spacing: -2){
              Image(value.icon)
                .resizable()
                .frame(width: 30, height: 30)
                .offset(y: selected == value ? 0 : -7)
              
              Text(value.description)
                .foregroundColor(Color("label"))
                .font(.custom("Outfit-Regular", size: 12))
                .opacity(selected == value ? 0 : 1)
                .offset(y: -4)
            }}
            .padding(.top)
            .frame(width: 70, height: 50)
        })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
