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
    var isPlayer: Bool
    
    init (namePlayer: String) {
        name = namePlayer
        coins = 10
        highscore = 10
        isPlayer = false
    }
}

