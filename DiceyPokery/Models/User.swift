//
//  User.swift
//  DiceyPokery
//
//  Created by Nguyen, Nguyen Dinh Dang on 23/08/2022.
//

import Foundation
import SwiftUI

struct User: Identifiable, Codable {
    var id = UUID()
    var name: String
    var coins: Int
    var highscore: Int
    
    init (namePlayer: String) {
        name = namePlayer
        coins = 10
        highscore = 10
    }
}


//@State private var highscore = UserDefaults.standard.integer(forKey: "highscore")
//@State private var coins = 10
//@State private var reels = [0, 0, 0]
//
//@State private var isChooseBet1 = false
//@State private var isChooseBet2 = false
//@State private var isChooseBetAll = false
//
//
//@State private var showingInfoView = false
//@State private var showGameOverModal = false
//@State private var gameWin = false
//@State private var gameInPlay = false
//
//@State private var animatingReel0 = true
//@State private var animatingReel1 = true
//@State private var animatingReel2 = true
//
////Add-in
//var player = "default"
//
//@State private var gameStart = true
//@State private var allIn = false
//@State private var coinPot = 0
//@State private var coinToBet = 0
//@State private var playerHand = 0
//@State private var botHand = 1
//@State private var currentanimation = 0
