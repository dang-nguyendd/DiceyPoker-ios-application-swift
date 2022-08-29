import SwiftUI

struct MenuView: View {
    @State private var showingLeaderboard = false
    @State private var showingInfo = false
    @State private var userDefault = User(namePlayer: "default")
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) var dismiss
    var user: User
    

    
    var body: some View {
        GeometryReader {screen in
            NavigationView {
                ZStack {
                    Glassmorphism1().onAppear(perform: {
                        userDefault = checkUserDefault(checkUser: user.name.uppercased())
                    })

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
