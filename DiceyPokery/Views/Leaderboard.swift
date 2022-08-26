//
//  Leaderboard.swift
//  DiceyPokery
//
//  Created by Nguyen, Nguyen Dinh Dang on 18/08/2022.
//

import SwiftUI

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
                        LeaderboardPanel(name: "Billie", score: 140)
                        LeaderboardPanel(name: "Billie", score: 140)
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
