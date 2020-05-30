//
//  PlayerModel.swift
//  Concentration-Game
//
//  Created by user165579 on 5/30/20.
//  Copyright © 2020 user165579. All rights reserved.
//

import Foundation

class Player {
    var playerName: String = ""
    var playerScore : String = ""
    var playerPlayDate: String = ""
    
    init(playerName: String, playerScore: String, playerPlayDate: String){
        self.playerName = playerName
        self.playerScore = playerScore
        self.playerPlayDate = playerPlayDate
    }
}
