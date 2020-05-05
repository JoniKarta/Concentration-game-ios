//
//  CardModel.swift
//  Concentration-Game
//
//  Created by user165579 on 5/5/20.
//  Copyright © 2020 user165579. All rights reserved.
//

import Foundation


class CardModel {
    
    
    func createCards() -> [Card]{
        // Declaration

        var cardsArray = [Card]()

        for _ in 1...8{
            
            let randomNumber = arc4random_uniform(13) + 1
            
            let cardOne = Card(cardName : "card\(randomNumber)")
            
            cardsArray.append(cardOne)
            
            let cardTwo = Card(cardName : "card\(randomNumber)")
            
            cardsArray.append(cardTwo)
            
        }
       return cardsArray
    }
}
