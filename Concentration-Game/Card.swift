//
//  Card.swift
//  Concentration-Game
//
//  Created by user165579 on 5/5/20.
//  Copyright © 2020 user165579. All rights reserved.
//

import Foundation


class Card {
     
    var cardName : String = ""
    var isFlipped : Bool = false
    var isMatched : Bool = false
    
    init(cardName : String){
        self.cardName = cardName
    }
    
}
