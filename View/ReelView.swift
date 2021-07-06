//
//  ReelView.swift
//  UI-252
//
//  Created by nyannyan0328 on 2021/07/05.
//

import SwiftUI
import AVKit

struct ReelView: View {
    @State var reels = MediaFileJSON.map { item ->Reel in
        
        let url = Bundle.main.path(forResource: item.url, ofType: "mp4") ?? ""
        
        let player = AVPlayer(url: URL(fileURLWithPath: url))
        
        return Reel(player: player, mediaFile: item)
        
    }
    
    @State var currentReel = ""
    var body: some View {
        GeometryReader{proxy in
            
            let size = proxy.size
            
            
            TabView(selection:$currentReel){
                
                ForEach($reels){$reels in

                    ReelsPlayer(reel: $reels, currrentReel:$currentReel)
                        .frame(width: size.width)
                        .rotationEffect(.init(degrees: -90))
                        .ignoresSafeArea(.all, edges: .top)
                        .tag(reels.id)
                     
                    
                   
                        
                    
                 
                
                    
                }
                
                
            }
            .rotationEffect(.init(degrees: 90))
            .frame(width: size.height)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
          .frame(width: size.width)
          
            
            
            
        }
        .background(.black)
        .ignoresSafeArea(.all, edges: .top)
        .onAppear {
            
            
            currentReel = reels.first?.id ?? ""
        }
    }
}

struct ReelView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ReelsPlayer : View{
    
    @Binding var reel : Reel
    @State var shoMore = false
    
    @State var isMuted = false
    @State var volumAnimation = false
    
    @Binding var currrentReel : String
    
    
    var body: some View{
        
        ZStack{
            
            if let player = reel.player{
                
                CustomVideoPlayer(player: player)
                
                GeometryReader{proxy -> Color in
                    
                    
                    let size = proxy.size
                    let minY = proxy.frame(in: .global).minY
                    
                    
                    DispatchQueue.main.async {
                        
                        
                        if -minY < (size.height / 2) && minY < (size.height / 2) && currrentReel == reel.id{
                            
                            
                            player.play()
                        }
                        else{
                            
                            player.pause()
                        }
                        
                        
                    }
                    
                    return Color.clear
                    
                    
                }
                
                Color.black.opacity(0.01)
                    .frame(width: 150, height: 150)
                    .onTapGesture {
                        if volumAnimation{
                            
                            return
                        }
                        isMuted.toggle()
                        player.isMuted = isMuted
                        
                        withAnimation{
                            
                            
                            volumAnimation.toggle()
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            
                            withAnimation{
                                
                                volumAnimation.toggle()
                            }
                            
                        }
                        
                        
                    }
                
                Color.black.opacity(shoMore ? 0.35 : 0)
                    .onTapGesture {
                        withAnimation{
                            
                            shoMore.toggle()
                        }
                    }
                
                VStack{
                    
                    HStack(alignment:.bottom){
                        
                        VStack(alignment: .leading, spacing: 15) {
                            
                            HStack(spacing:15){
                                
                                
                                
                                Image("pro")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                
                                Text("BABY")
                                    .font(.callout.bold())
                                    .fontWeight(.bold)
                                
                                
                                Text("Follow")
                                    .font(.caption.bold())
                                    .foregroundColor(.white)
                                    
                            }
                            
                            ZStack{
                                
                                
                                if shoMore{
                                    
                                    ScrollView(.vertical, showsIndicators: false) {
                                        
                                        
                                        Text(reel.mediaFile.title + sampleText)
                                            .font(.footnote)
                                            .fontWeight(.bold)
                                          
                                        
                                        
                                    }
                                    .frame(height: 150)
                                    .onTapGesture {
                                        withAnimation{
                                            
                                            shoMore.toggle()
                                        }
                                    }
                                }
                                
                                
                                else{
                                    
                                    
                                    Button {
                                        withAnimation{shoMore.toggle()}
                                    } label: {
                                        
                                        HStack{
                                            
                                            
                                            Text(reel.mediaFile.title)
                                                .font(.footnote)
                                                .fontWeight(.bold)
                                                .lineLimit(1)
                                            
                                            Text("More")
                                        }
                                        .padding(.top,6)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                    }

                                    
                                }
                            }
                            
                            
                        }
                        
                        
                        Spacer(minLength: 0)
                        
                        
                        ActtionButton(reel: reel)
                        
                    }
                    
                    
                    HStack{
                        
                        Text("A Sky full of Stars")
                            .font(.title.bold())
                            .foregroundColor(.black)
                        
                        Spacer(minLength: 10)
                        
                        
                        Button {
                            
                            
                        } label: {
                            Image("album")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                              .clipShape(Circle())
                                .background(
                                
                               Circle()
                                    .stroke(Color.white,lineWidth: 3)
                                )
                        }

                        
                        
                    }
                    
                    
                    
                }
                .padding(.horizontal)
                .padding(.bottom,20)
                .foregroundColor(.white)
                .frame(maxHeight: .infinity, alignment: .bottom)
                Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(.secondary)
                    .clipShape(Circle())
                    .foregroundStyle(.black)
                    .opacity(volumAnimation ? 1 : 0)
                
                
                
            }
            
        }
        
    }
}

struct ActtionButton : View{
    var reel : Reel
    var body: some View{
        
        VStack(spacing:15){
            
            
            Button {
                
            } label: {
                VStack(spacing:15){
                    
                    Image(systemName: "suit.heart")
                        .font(.title)
                    
                    Text("255")
                }
            }
            
            Button {
                
            } label: {
                VStack(spacing:15){
                    
                    Image(systemName: "bubble.right")
                        .font(.title)
                    
                    Text("120")
                }
            }
            Button {
                
            } label: {
                VStack(spacing:15){
                    
                    Image(systemName: "paperplane")
                        .font(.title)
                    
                    Text("Send")
                }
            }
            
            Button {
                
            } label: {
                
                Image("menu 2")
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: 50, height: 50)
                    .rotationEffect(.init(degrees: 90))
                
            }

            

            
            
        }
        
        
    }
    
    
    
}

let sampleText = "The cheetah (Acinonyx jubatus) is a large cat native to Africa and central Iran. It is the fastest land animal, estimated to be capable of running at 80 to 128 km/h (50 to 80 mph) with the fastest reliably recorded speeds being 93 and 98 km/h (58 and 61 mph), and as such has several adaptations for speed, including a light build, long thin legs and a long tail. It typically reaches 67–94 cm (26–37 in) at the shoulder, and the head-and-body length is between 1.1 and 1.5 m (3 ft 7 in and 4 ft 11 in). Adults weigh between 21 and 72 kg (46 and 159 lb). Its head is small, rounded, and has a short snout and black tear-like facial streaks. The coat is typically tawny to creamy white or pale buff and is mostly covered with evenly spaced, solid black spots. Four subspecies are recognised.The cheetah lives in three main social groups, females and their cubs, male coalitions and solitary males. While females lead a nomadic life searching for prey in large home ranges, males are more sedentary and may instead establish much smaller territories in areas with plentiful prey and access to females. The cheetah is active mainly during the day, with peaks during dawn and dusk. It feeds on small- to medium-sized prey, mostly weighing under 40 kg (88 lb), and prefers medium-sized ungulates such as impala, springbok and Thomson's gazelles. The cheetah typically stalks its prey to within 60–70 m (200–230 ft), charges towards it, trips it during the chase and bites its throat to suffocate it to death. It breeds throughout the year. After a gestation of nearly three months, a litter of typically three or four cubs is born. Cheetah cubs are highly vulnerable to predation by other large carnivores such as hyenas and lions. They are weaned at around four months and are independent by around 20 months of age."

