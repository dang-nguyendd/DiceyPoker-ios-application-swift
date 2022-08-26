//
//  ContentView.swift
//  glassmorphismPart2
//
//  Created by Logan Koshenka on 9/29/21.
//

import SwiftUI

struct MenuView: View {
    @State private var showingLeaderboard = false
    @State private var showingInfo = false
    @State private var userDefault = User(namePlayer: "default")
    
    @Environment(\.dismiss) var dismiss
    var user: User
    
    var body: some View {
        GeometryReader {screen in
            NavigationView {
                ZStack {
                    LinearGradient(colors: [Color.cyan.opacity(0.7), Color.purple.opacity(0.3)], startPoint: .top, endPoint: .bottom)
                    
                    Circle()
                        .frame(width: 300)
                        .foregroundColor(Color.blue.opacity(0.3))
                        .blur(radius: 10)
                        .offset(x: -100, y: -150)
                    
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .frame(width: 400, height: 400)
                        .foregroundStyle(LinearGradient(colors: [Color.purple.opacity(0.6), Color.mint.opacity(0.5)], startPoint: .top, endPoint: .leading))
                        .offset(x: 300)
                        .blur(radius: 30)
                        .rotationEffect(.degrees(30))
                    
                    Circle()
                        .frame(width: 400)
                        .foregroundStyle(Color.pink.opacity(0.6))
                        .blur(radius: 20)
                        .offset(x: 200, y: -200)
                    
                    VStack(spacing: 20) {
                        Text("hello, \(self.user.name)!")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .frame(alignment: .center)
                            .padding()
                        
                        NavigationLink(destination: ContentView(player: readUserDefault(checkUser: user.name))) {
                            Text("play game".uppercased())
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .frame(alignment: .center)
                                .padding()
                                .frame(width: screen.size.width/1.15)
                                .foregroundStyle(LinearGradient(colors: [.blue, .indigo], startPoint: .top, endPoint: .bottom))
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                        
                        Text("leaderboard".uppercased())
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .frame(alignment: .center)
                            .padding()
                            .frame(width: screen.size.width/1.15)
                            .foregroundStyle(LinearGradient(colors: [.blue, .indigo], startPoint: .top, endPoint: .bottom))
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .onTapGesture {
                                showingLeaderboard.toggle()
                            }
                            .sheet(isPresented: $showingLeaderboard) {
                                Leaderboard()
                            }
                        
                        
                        
                        Text("how to play".uppercased())
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .frame(alignment: .center)
                            .padding()
                            .frame(width: screen.size.width/1.15)
                            .foregroundStyle(LinearGradient(colors: [.blue, .indigo], startPoint: .top, endPoint: .bottom))
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .onTapGesture {
                                showingInfo.toggle()
                            }
                            .sheet(isPresented: $showingInfo) {
                                InfoView()
                            }
                        
                    }
                }
                .onAppear(perform: {playSound(sound: "soundtrack", type: "mp3")}
                )
                .edgesIgnoringSafeArea(.all)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarBackButtonHidden(true)
            .accentColor(.pink)
            
        }
    }
}

//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView(user: user = User.init(namePlayer: "default"))
//    }
//}
