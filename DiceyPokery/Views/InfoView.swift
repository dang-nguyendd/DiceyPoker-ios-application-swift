import SwiftUI

struct InfoView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        GeometryReader {screen in
            ZStack {
                Glassmorphism1()
                
                    VStack(alignment: .leading, spacing: 0) {
                        Text("how to play".uppercased())
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.pink)
                        Spacer()
                        Text("Click 'play game' to start. Choose an amount of chips and click bet to place. You have 3 turns to place your bet. After 3 turns, the bot will reveal their hand. If your hand has more matches than the bot's, you will win the total pot. You can still place your bet (Except for option 'All In') during the round even if you run out of chips. The game last for good and if you lose all your chips after a round, game is over for you, you have to log in with another account to start over.")
                            .font(.caption)
                            .foregroundStyle(Color.pink)
                        
                        Spacer()
                        Text("App: Dicey Pokery\nAuthor: Nguyen Nguyen\nGenre: Gambling - Dice Game\nPublish Date: August 2022")
                            .font(.headline)
                            .foregroundColor(.green)
                        
                    }
                    .padding()
                    .frame(width: screen.size.width/1.23, height: screen.size.height/2)
                    .foregroundColor(Color.black.opacity(0.8))
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                }
            }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
            .preferredColorScheme(.light)
    }
}

