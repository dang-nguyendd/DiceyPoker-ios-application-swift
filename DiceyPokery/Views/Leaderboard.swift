import SwiftUI


func checkAchievement(user: User) -> String{
    if user.highscore >= 100 return "Pro"
    else if user.highscore >= 300 return "Master"
    else if user.highscore >= 500 return "Supreme"
    else if user.highscore <= 0 return "Loser"
}

struct Leaderboard: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        GeometryReader {screen in
            ZStack(alignment: .top){
                Glassmorphism1()
                VStack(alignment: .center, spacing: 0) {
                    Text("Leaderboard".uppercased())
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.pink)
                        .frame(alignment: .center)
                        .padding()
                    VStack(alignment: .leading, spacing: 10) {
                        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
                            var user = readUserDefault(checkUser: key)
                            LeaderboardPanel(name: user.name + "\(checkAchievement(user: user))", user.highscore)
                        }
                    }
                    .frame(width: screen.size.width/1.15)
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
