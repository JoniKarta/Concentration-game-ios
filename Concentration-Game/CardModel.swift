//
//  CardModel.swift
//  Concentration-Game
//
//  Created by Jonathan Karta on 5/5/20.
//  Copyright © 2020 Jonathan Karta. All rights reserved.
//

import Foundation


class CardModel {
    
    // This function generated random and unique pairs of cards
    func createCards() -> [Card]{
        var cardsArray = [Card]()
        var trackGeneratedNumbers : [UInt32] = [UInt32]()
        while trackGeneratedNumbers.count < 8 {
            let cardNumber = arc4random_uniform(12) + 1
            if trackGeneratedNumbers.contains(cardNumber) == false {
                trackGeneratedNumbers.append(cardNumber)
                let cardOne = Card(cardName : "card\(cardNumber)")
                let cardTwo = Card(cardName : "card\(cardNumber)")
                cardsArray.append(cardOne)
                cardsArray.append(cardTwo)
                print(cardNumber)
            }
        }
        return cardsArray.shuffled()
    }
}
