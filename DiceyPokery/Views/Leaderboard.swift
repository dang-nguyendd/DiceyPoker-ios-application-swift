/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Nguyen Dinh Dang Nguyen
  ID: s3759957
  Created  date: 01/8/2022
  Last modified: 29/8/2022
  Acknowledgement: None
*/

import SwiftUI

struct Leaderboard: View {
    @Environment(\.dismiss) var dismiss
    @State var arrPlayer = [User]()
    
    func checkAchievement(user: User) -> String{
        if user.highscore >= 500 {return "Supreme"}
        else if user.highscore >= 300 {return "Master"}
        else if user.highscore >= 100 {return "Pro"}
        else {return "No title"}
    }
    
    func loopAchievement(){
        for (key, _value) in UserDefaults.standard.dictionaryRepresentation() {
            var user = readUserDefault(checkUser: key)
            if user.isPlayer {
                arrPlayer.append(user)
            }
        }
    }
    
    var body: some View {
        GeometryReader {screen in
            ZStack(alignment: .top){
                Glassmorphism1()
                    .onAppear(perform: {
                        //                        let domain = Bundle.main.bundleIdentifier!
                        //                        UserDefaults.standard.removePersistentDomain(forName: domain)
                        loopAchievement()
                    })
                VStack(alignment: .center, spacing: 0) {
                    Text("Leaderboard".uppercased())
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.pink)
                        .frame(alignment: .center)
                        .padding()
                    ScrollView(.vertical){
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(arrPlayer) {arrPlayer in
                                LeaderboardPanel(name: "\(arrPlayer.name) | \(checkAchievement(user: arrPlayer))", score: arrPlayer.highscore)
                            }
                        }
                        .frame(width: screen.size.width/1.15)
                    }
                }
                .padding(.top, screen.size.height/50)
            }
        }
    }
}

struct Leaderboard_Previews: PreviewProvider {
    static var previews: some View {
        Leaderboard()
            .preferredColorScheme(.light)
    }
}
