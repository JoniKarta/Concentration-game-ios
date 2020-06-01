//
//  PlayerModel.swift
//  Concentration-Game
//
//  Created by user165579 on 5/30/20.
//  Copyright © 2020 user165579. All rights reserved.
//

import Foundation

class Player : Codable, CustomStringConvertible{
    var name: String = ""
    var score : Int = 0
    var datePlayed: String = ""
    var location: Location = Location()
    
    init() {
        
    }
    
    init(playerName: String, playerScore: Int, playerPlayDate: String, location: Location){
        self.name = playerName
        self.score = playerScore
        self.datePlayed = playerPlayDate
        self.location = location
    }
    
    public var description: String {
        return "Player Details: \n Name: \(self.name)\n Score: \(self.score)\n Date: \(self.datePlayed)\n \(String(describing: self.location)) "
    }
}
