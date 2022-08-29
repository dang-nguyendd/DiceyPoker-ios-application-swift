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

