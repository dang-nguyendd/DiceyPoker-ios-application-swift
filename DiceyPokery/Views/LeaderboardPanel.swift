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

struct LeaderboardPanel: View {
    var name: String
    var score: Int
    var body: some View {
        HStack {
            Text("\(name)".uppercased())
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .frame(alignment: .leading)
                .padding()
            Spacer()
            Text("\(score)$".uppercased())
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .frame(alignment: .trailing)
                .padding()
        }
        .foregroundStyle(LinearGradient(colors: [.blue, .indigo], startPoint: .top, endPoint: .bottom))
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

struct LeaderboardPanel_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardPanel(name: "Bille", score: 23)
    }
}
