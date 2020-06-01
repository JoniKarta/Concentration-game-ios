//
//  CardModel.swift
//  Concentration-Game
//
//  Created by Jonathan Karta on 5/5/20.
//  Copyright © 2020 Jonathan Karta. All rights reserved.
//

import Foundation


class GameModel {
    private var cardsArray = [Card]()
    private var numberOfPairCards : Int = 10
    
    // This function generates random and unique pairs of cards
    func createCards() -> [Card]{
        var trackGeneratedNumbers : [UInt32] = [UInt32]()
        while trackGeneratedNumbers.count < numberOfPairCards{
            let cardNumber = arc4random_uniform(12) + 1
            if trackGeneratedNumbers.contains(cardNumber) == false {
                trackGeneratedNumbers.append(cardNumber)
                let cardOne = Card(cardName : "card\(cardNumber)")
                let cardTwo = Card(cardName : "card\(cardNumber)")
                cardsArray.append(cardOne)
                cardsArray.append(cardTwo)
            }
        }
        return cardsArray.shuffled()
    }
    
    func checkGameBoard()-> Bool{
        for card in cardsArray {
            if card.isMatched == false {
                return false
            }
        }
        return true
    }
}
