//
//  Home.swift
//  UI-252
//
//  Created by nyannyan0328 on 2021/07/05.
//

import SwiftUI

struct Home: View {
    @State var currentTab = "reels"
    @Namespace var animation
    
    init(){
        
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        VStack(spacing:0){
            
            TabView(selection:$currentTab){
                
                Text("Home")
                    .tag("house.fill")
                
                Text("Settings")
                    .tag("gear")
                
                ReelView()
                    .tag("reels")

                
                Text("Like")
                    .tag("suit.heart.fill")
                
                Text("Private")
                    .tag("person.3.fill")
                
                
                
                
                
            }
            
            HStack(spacing:0){
                
                
                ForEach(["house.fill","gear","reels","suit.heart.fill","person.3.fill"],id:\.self){image in
                    
                    
                    
                    TabButton(image: image, selected: $currentTab, animation: animation, issystemImage: image != "reels")
                }
                
                
                
                
            }
            .padding(.vertical)
            .padding(.horizontal,15)
            .overlay(Divider().background(.green),alignment: .top)
            .background(currentTab == "reels" ? .black : .white)
            
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct TabButton : View{
    
    var image : String
    @Binding var selected : String
    var animation : Namespace.ID
    var issystemImage : Bool
    
    var body: some View{
        
        
        Button {
            withAnimation{
                
                selected = image
            }
        } label: {
            ZStack{
                
                VStack(spacing:15){
                    
                    
                    if issystemImage{
                        
                        
                        Image(systemName: image)
                            .font(.title2)
                    }
                    
                    else{
                        
                        
                        Image(image)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                        
                    }
                    
                    
                    if selected == image{
                        
                        Capsule()
                            .fill(Color.green)
                            .frame(width: 35, height: 5)
                            .matchedGeometryEffect(id: "TAB", in: animation)
                        
                    }
                    else{
                        
                        Capsule()
                            .fill(Color.clear)
                            .frame(width: 35, height: 5)
                        
                        
                        
                        
                    }
                }
                
            }
            .foregroundColor(selected == image ? selected == "reels" ? .white : .pink : .gray)
            .frame(maxWidth: .infinity)
        }

    }
}
