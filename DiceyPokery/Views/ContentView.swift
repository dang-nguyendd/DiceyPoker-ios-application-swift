import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    let icons = ["blue-1","blue-2","blue-3","blue-4","blue-5","blue-6"]
    
    var player: User
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var userDefault = User(namePlayer: "default")
    
    @State private var highscore = 10
    @State private var coins = 10
    @State private var reels = [0, 0, 0]
    
    @State private var isChooseBet1 = false
    @State private var isChooseBet2 = false
    @State private var isChooseBetAll = false
    
    
    @State private var showingInfoView = false
    @State private var showGameOverModal = false
    @State private var gameWin = false
    @State private var gameInPlay = false
    
    @State private var animatingReel0 = true
    @State private var animatingReel1 = true
    @State private var animatingReel2 = true
    
    //Add-in
    
    
    @State private var gameStart = true
    @State private var allIn = false
    @State private var coinPot = 0
    @State private var coinToBet = 0
    @State private var playerHand = 0
    @State private var botHand = 0
    @State private var currentanimation = 0
    
    // MARK: - FUNCTIONS (GAME LOGICS)
    
    // MARK: - SPIN LOGIC
    func drawDicePlayer(){
        playerHand = Int.random(in: 0...icons.count-1)
        playSound(sound: "spin", type: "mp3")
    }
    
    func drawDiceBot(){
        botHand = Int.random(in: 0...icons.count-1)
        playSound(sound: "spin", type: "mp3")
    }
    
    func spinReel(reelNum: Int){
        reels[reelNum] = Int.random(in: 0...icons.count-1)
    }
    func checkAnimation(){
        //Trigger the animation of each reel based on the state of current reel
        if currentanimation == 0 {
            // NO ANIMATION
            withAnimation{
                self.animatingReel0 = false
            }
            
            // SPIN THE REELS
            self.spinReel(reelNum: 0)
            
            // TRIGGER ANIMATION
            withAnimation{
                self.animatingReel0 = true
            }
        }
        else if currentanimation == 1 {
            // NO ANIMATION
            withAnimation{
                self.animatingReel1 = false
            }
            
            // SPIN THE REELS
            self.spinReel(reelNum: 1)
            
            // TRIGGER ANIMATION
            withAnimation{
                self.animatingReel1 = true
            }
        }
        else if currentanimation == 2 {
            // NO ANIMATION
            withAnimation{
                self.animatingReel2 = false
            }
            
            // SPIN THE REELS
            self.spinReel(reelNum: 2)
            
            // TRIGGER ANIMATION
            withAnimation{
                self.animatingReel2 = true
            }
        }
        
        //switch the state of current reel
        currentanimation += 1
    }
    
    
    
    // MARK: - CHECK WINNING LOGIC
    func checkWinning(){
        var countPlayer = 0
        var countBot = 0
        gameInPlay = false
        reels.forEach { reel in
            if reel == playerHand {
                countPlayer += 1
            }
            if reel == botHand {
                countBot += 1
            }
            if countPlayer > countBot {
                // PLAYER WINS LOGIC
                playerWins()
                
                // NEW HIGHSCORE LOGIC
                if coins > highscore{
                    newHighScore()
                } else {
                    playSound(sound: "winning", type: "mp3")
                }
                
            }
        }
        countPlayer = 0
        countBot = 0
    }
    
    // MARK: - PLAYER WIN LOGIC
    func playerWins() {
        coins += coinPot
    }
    
    // MARK: - HIGHSCORE LOGIC
    func newHighScore(){
        highscore = coins
        userDefault.highscore = coins
        setUserDefault(user: userDefault)
        playSound(sound: "highscore", type: "mp3")
    }
    
    // MARK: - PLAYER LOSE LOGIC
    
    // MARK: - BET 2 LOGIC
    func chooseBet2() {
        coinToBet = 2
        //        coins -= 20
        //        coinPot += 40
        isChooseBet2 = true
        isChooseBet1 = false
        isChooseBetAll = false
        playSound(sound: "bet-chip", type: "mp3")
    }
    
    // MARK: - BET 1 LOGIC
    func chooseBet1() {
        coinToBet = 1
        //        coins -= 10
        //        coinPot += 20
        isChooseBet1 = true
        isChooseBet2 = false
        isChooseBetAll = false
        playSound(sound: "bet-chip", type: "mp3")
    }
    func chooseBetAll() {
        coinToBet = coins
        //        coins -= coins
        //        coinPot += (coins*2)
        isChooseBetAll = true
        isChooseBet1 = false
        isChooseBet2 = false
        playSound(sound: "bet-chip", type: "mp3")
    }
    
    // MARK: - GAME OVER LOGIC
    func isGameOver() {
        if coins <= 0 {
            // SHOW MODAL MESSAGE OF GAME OVER
            showGameOverModal = true
            playSound(sound: "gameover", type: "mp3")
        }
    }
    
    // MARK: - RESET GAME LOGIC
    func resetGame(){
        drawDicePlayer()
        drawDiceBot()
        coinPot = 0
        coinToBet = 0
        currentanimation = 0
        animatingReel0 = false
        animatingReel1 = false
        animatingReel2 = false
        
        playSound(sound: "ring-up", type: "mp3")
    }
    func startGame(){
        drawDicePlayer()
        drawDiceBot()
        userDefault.name = player.name
        userDefault.coins = player.coins
        userDefault.highscore = player.highscore
        coins = player.coins
        highscore = player.highscore
    }
    func saveGame(){
        userDefault.coins = coins
        userDefault.highscore = highscore
        setUserDefault(user: userDefault)
    }
    
    
    
    // MARK: - BODY
    
    var body: some View {
        
        GeometryReader {screen in
            ZStack {
                // MARK: - BACKGROUND
                Glassmorphism1()
                
                // MARK: - GAME UI
                VStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    // MARK: - LOGO HEADER
                    LogoView(logoFileName: "logo")
                    
                    // MARK: - SCORE
                    HStack{
                        HStack{
                            Text("Your\nChips".uppercased())
                                .modifier(scoreLabelStyle())
                                .multilineTextAlignment(.trailing)
                            Text("\(coins)")
                                .modifier(scoreNumberStyle())
                        }
                        .frame(width: screen.size.width/4.5)
                        .modifier(scoreCapsuleStyle())
                        Spacer()
                        HStack{
                            Text("Total\nPot".uppercased())
                                .modifier(scoreLabelStyle())
                            Text("\(coinPot)")
                                .modifier(scoreNumberStyle())
                                .multilineTextAlignment(.leading)
                            
                        }
                        .frame(width: screen.size.width/4.5)
                        .modifier(scoreCapsuleStyle())
                        Spacer()
                        HStack{
                            Text("\(userDefault.highscore)")
                                .modifier(scoreNumberStyle())
                                .multilineTextAlignment(.leading)
                            Text("Record\nChips".uppercased())
                                .modifier(scoreLabelStyle())
                            
                        }
                        .frame(width: screen.size.width/4.5)
                        .modifier(scoreCapsuleStyle())
                    }
                    .padding(.horizontal, screen.size.width/100)
                    
                    // MARK: - SLOT MACHINE
                    VStack{
                        ZStack{
                            ReelView()
                            if (!gameInPlay) {
                                Image(icons[botHand])
                                    .resizable()
                                    .modifier(IconImageModifier())
                            }
                        }
                        
                        HStack{
                            // MARK: - FIRST REEL
                            ZStack{
                                ReelView()
                                Image(icons[reels[0]])
                                    .resizable()
                                    .modifier(IconImageModifier())
                                    .opacity(animatingReel0 ? 1 : 0)
                                    .offset(y: animatingReel0 ? 0 : -50)
                                    .animation(.easeOut(duration: Double.random(in: 0.5...0.7)), value: animatingReel0)
                                    .onAppear(perform: {
                                        self.animatingReel0.toggle()
                                        playSound(sound: "blink", type: "mp3")
                                    })
                            }
                            
                            Spacer()
                            
                            // MARK: - SECOND REEL
                            ZStack{
                                ReelView()
                                Image(icons[reels[1]])
                                    .resizable()
                                    .modifier(IconImageModifier())
                                    .opacity(animatingReel1 ? 1 : 0)
                                    .offset(y: animatingReel1 ? 0 : -50)
                                    .animation(.easeOut(duration: Double.random(in: 0.7...0.9)), value: animatingReel1)
                                    .onAppear(perform: {
                                        self.animatingReel1.toggle()
                                        playSound(sound: "blink", type: "mp3")
                                    })
                            }
                            
                            Spacer()
                            
                            // MARK: - THIRD REEL
                            ZStack{
                                ReelView()
                                Image(icons[reels[2]])
                                    .resizable()
                                    .modifier(IconImageModifier())
                                    .opacity(animatingReel2 ? 1 : 0)
                                    .offset(y: animatingReel2 ? 0 : -50)
                                    .animation(.easeOut(duration: Double.random(in: 0.9...1.1)), value: animatingReel2)
                                    .onAppear(perform: {
                                        self.animatingReel2.toggle()
                                        //playSound(sound: "blink", type: "mp3")
                                    })
                            }
                        }
                        
                        // MARK: - PLAYER HAND
                        ZStack{
                            ReelView()
                            if (!gameStart && !showGameOverModal){
                                Image(icons[playerHand])
                                    .resizable()
                                    .modifier(IconImageModifier())
                            }
                        }
                        
                        
                        
                        // MARK: - SPIN BUTTON
                        Button {
                            print("player: \(playerHand) bot: \(botHand) \(userDefault)")
                            if coinToBet > 0 && gameInPlay {
                                checkAnimation()
                                coinPot += coinToBet*2
                                coins -= coinToBet
                                coinToBet = 0
                                isChooseBet1 = false
                                isChooseBet2 = false
                                isChooseBetAll = false
                                
                                if currentanimation >= 3 {
                                    //CHECK WINNING
                                    self.checkWinning()
                                    
                                    // GAME OVER
                                    self.isGameOver()
                                }
                            } else if !gameInPlay {
                                resetGame()
                                gameInPlay = true
                            }
                            saveGame()
                        } label: {
                            
                            ZStack(){
                                Image("reel")
                                    .resizable()
                                    .modifier(ReelImageModifier())
                                if gameInPlay {
                                    Text("BET")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .heavy, design: .rounded))
                                        .modifier(ShadowModifier())
                                }
                                else if !gameInPlay{
                                    Text("AGAIN")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .heavy, design: .rounded))
                                        .modifier(ShadowModifier())
                                }
                            }
                        }
                    }
                    
                    
                    // MARK: - FOOTER
                    
                    HStack{
                        
                        HStack (spacing: screen.size.width/500){
                            
                            // MARK: - BET ALL IN BUTTON
                            Button {
                                self.chooseBetAll()
                            } label: {
                                VStack(spacing: screen.size.height/40){
                                    Image("casino-chips")
                                        .resizable()
                                        .offset(y: isChooseBetAll ? 0 : -20)
                                        .opacity(isChooseBetAll ? 1 : 0 )
                                        .modifier(CasinoChipModifier())
                                        .animation(.default, value: isChooseBetAll)
                                    Text("All In")
                                        .foregroundColor(isChooseBetAll ? Color("ColorBlueRMIT") : Color.white)
                                        .modifier(BetCapsuleModifier())
                                }
                                .padding()
                            }
                            .padding(.leading, screen.size.width/10)
                            .disabled(coins <= 0 || !gameInPlay)
                            Spacer()
                            
                            // MARK: - BET 2 BUTTON
                            Button {
                                self.chooseBet2()
                            } label: {
                                VStack(spacing: screen.size.height/40){
                                    Image("casino-chips")
                                        .resizable()
                                        .offset(y: isChooseBet2 ? 0 : -20)
                                        .opacity(isChooseBet2 ? 1 : 0 )
                                        .modifier(CasinoChipModifier())
                                        .animation(.default, value: isChooseBet2)
                                    Text("2")
                                        .foregroundColor(isChooseBet2 ? Color("ColorBlueRMIT") : Color.white)
                                        .modifier(BetCapsuleModifier())
                                }
                                .padding()
                            }.disabled(!gameInPlay)
                            
                            Spacer()
                            
                            // MARK: - BET 1 BUTTON
                            Button {
                                self.chooseBet1()
                            } label: {
                                VStack(spacing: screen.size.height/40){
                                    Image("casino-chips")
                                        .resizable()
                                        .offset(y: isChooseBet1 ? 0 : -20)
                                        .opacity(isChooseBet1 ? 1 : 0 )
                                        .modifier(CasinoChipModifier())
                                        .animation(.default, value: isChooseBet1)
                                    Text("1")
                                        .foregroundColor(isChooseBet1 ? Color("ColorBlueRMIT") : Color.white)
                                        .modifier(BetCapsuleModifier())
                                    
                                }
                                .padding()
                            }
                            .padding(.trailing, screen.size.width/10)
                            .disabled(!gameInPlay)
                        }
                    }
                    .padding(.bottom, screen.size.height/30)
                    
                }
                
                
                // MARK: - GAMESTART MODAL
                if gameStart{
                    ZStack{
                        Color("ColorBlackTransparent")
                            .edgesIgnoringSafeArea(.all)
                        VStack{
                            Text("DICEY POKERY")
                                .font(.system(.title, design: .rounded))
                                .fontWeight(.heavy)
                                .foregroundColor(Color.pink)
                                .padding()
                                .frame(width: screen.size.width/1.1)
                                .background(.white)
                            
                            Spacer()
                            
                            VStack {
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screen.size.height/5)
                                Text("Welcome to Dicey Pokery!\nLet's kick some NPC's ass!\n Press button to start game!")
                                    .font(.system(.body, design: .rounded))
                                    .foregroundColor(Color.pink)
                                    .multilineTextAlignment(.center)
                                Button {
                                    self.gameStart = false
                                    self.gameInPlay = true
                                    self.startGame()
                                    self.saveGame()
                                } label: {
                                    Text("New Game".uppercased())
                                }
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .padding(.vertical,10)
                                .padding(.horizontal, 20)
                                .foregroundColor(Color.pink)
                                .background(
                                    Capsule()
                                        .strokeBorder(lineWidth: 2)
                                        .foregroundColor(.pink)
                                )
                                
                            }
                            Spacer()
                        }
                        .frame(width: screen.size.width/1.23, height: screen.size.height/1.2)
                        .foregroundColor(Color.black.opacity(0.8))
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                    }.onAppear(perform: {
                        playSound(sound: "drum-music", type: "mp3")
                    })
                }//ZStack
                
                
                
                // MARK: - GAMEOVER MODAL
                if showGameOverModal{
                    ZStack{
                        Color("ColorBlackTransparent")
                            .edgesIgnoringSafeArea(.all)
                        VStack{
                            Text("GAME OVER")
                                .font(.system(.title, design: .rounded))
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                                .padding()
                                .frame(width: screen.size.width/1.1)
                                .background(Color("ColorRedRMIT"))
                            
                            Spacer()
                            
                            VStack {
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screen.size.height/5)
                                Text("You lost all money!\nYou are not the god of gambler!\n Good luck next time!")
                                    .font(.system(.body, design: .rounded))
                                    .foregroundColor(Color.pink)
                                    .multilineTextAlignment(.center)
                                Button {
                                    self.showGameOverModal = false
                                    presentationMode.wrappedValue.dismiss()
                                } label: {
                                    Text("Exit".uppercased())
                                }
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .foregroundColor(Color.pink)
                                .background(
                                    Capsule()
                                        .strokeBorder(lineWidth: 2)
                                        .foregroundColor(Color("ColorRedRMIT"))
                                )
                                
                            }
                            Spacer()
                        }
                        .frame(width: screen.size.width/1.23, height: screen.size.height/1.2)
                        .foregroundColor(Color.black.opacity(0.8))
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                    }.onAppear(perform: {
                        playSound(sound: "drum-music", type: "mp3")
                    })
                }
            }
            .navigationBarBackButtonHidden(true)
            .edgesIgnoringSafeArea(.all)
            .navigationBarItems(leading: Button("Menu") {
                presentationMode.wrappedValue.dismiss()
            })
        }
        //        override func viewWillLayoutSubviews() {
        //           let barButton = UIBarButtonItem()
        //           barButton.title = "custom"
        //           barButton.action = #selector(barButtonAction)
        //           barButton.target = self
        //           self.navigationItem.setLeftBarButton(barButton, animated: true) }
        //           @objc func barButtonAction() {
        //               presentationMode.wrappedValue.dismiss() }
    }
}
// MARK: - PREVIEW
//    struct ContentView_Previews: PreviewProvider {
//        static var previews: some View {
//            ContentView(player: User(namePlayer: "defak"))
//                .preferredColorScheme(.light)
//        }
//    }
//

