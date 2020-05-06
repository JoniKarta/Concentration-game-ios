//
//  ViewController.swift
//  Concentration-Game
//
//  Created by Jonathan Karta on 5/5/20.
//  Copyright © 2020 user165579. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate

{
    @IBOutlet weak var game_LBL_moves: UILabel!
    @IBOutlet weak var game_COLVIEW_cardsCollection: UICollectionView!
    private var cards : [Card] = [Card]()
    private var model = CardModel()
    private var countMoves : Int = 0
    private var firstCardFlipped : IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCardsLayout()
        game_COLVIEW_cardsCollection.delegate = self
        game_COLVIEW_cardsCollection.dataSource = self
        cards = model.createCards()
    }
    // MARK: - UICollectionView Protocol Methods
   
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return cards.count
       }
    
    func collectionView(_ collectionView:UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardView", for: indexPath) as! CardCollectionViewCell
        let card = cards[indexPath.row]
        cell.setCard(card)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        cell.flip()
        let selectedCard = cards[indexPath.row]
        
        if selectedCard.isFlipped == false {
            // Flip the card
            cell.flip()
            
            // Changed the state of the card
            selectedCard.isFlipped = true
            
            if firstCardFlipped == nil{ // Which means it's the first card the player flip
                firstCardFlipped = indexPath
            }else{
                // It's the second card
                hasMatch(firstCardIndex: firstCardFlipped!, secondCardIndex: indexPath)
            }
        }else {
            cell.flipBack()
        }
    }
    
    // MARK: - Configuaration of main layout
    func configureCardsLayout() {
        let width = (view.frame.size.width - 40) / 4
        let layout = game_COLVIEW_cardsCollection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }

//        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//            super.viewWillTransition(to: size, with: coordinator)
//            if UIDevice.current.orientation.isLandscape {
//                print("Landscape")
//                let width = (view.frame.size.width - 20) / 3
//                let layout = game_CV_cardscollection.collectionViewLayout as! UICollectionViewFlowLayout
//                layout.itemSize = CGSize(width: width, height: width)
//
//            } else {
//                print("Portrait")
//                        }
//        }
    // MARK: - Game logic
    
    func hasMatch(firstCardIndex : IndexPath, secondCardIndex : IndexPath) {
        // Update number of moves in the game
        updateMove()
        
        // Gets cards view
        let cardOneCellView = game_COLVIEW_cardsCollection.cellForItem(at: firstCardIndex) as? CardCollectionViewCell
        let cardTwoCellView = game_COLVIEW_cardsCollection.cellForItem(at: secondCardIndex) as? CardCollectionViewCell

        // Get the cards entity
        let cardOne : Card = self.cards[firstCardIndex.row]
        let cardTwo : Card = self.cards[secondCardIndex.row]
        
        if cardOne.cardName == cardTwo.cardName {
            
            // Change the state of the cards
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            // Remove the cards from the view
            cardOneCellView?.remove()
            cardTwoCellView?.remove()
            
        }else{
        
            // Change the entity's state
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            // Flip the cards back
            cardOneCellView?.flipBack()
            cardTwoCellView?.flipBack()
        }
        // Track if the first cards has flipped
        self.firstCardFlipped = nil
        
    }
    
    func updateMove() {
        self.countMoves = Int(game_LBL_moves.text!)!
        self.countMoves +=  1
        self.game_LBL_moves.text = String(countMoves)
    }
    
    
}

