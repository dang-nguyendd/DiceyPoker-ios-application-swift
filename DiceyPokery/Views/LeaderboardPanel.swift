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
