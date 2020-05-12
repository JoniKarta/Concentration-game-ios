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
    @IBOutlet weak var game_LBL_timer: UILabel!
    
    private var cards : [Card] = [Card]()
    private var model = CardModel()
    private var countMoves : Int = 0
    private var firstCardIndexPath : IndexPath?
    private var secondCardIndexPath : IndexPath?
    private var firstCardFlipped : Card?
    private var gameTimer : Timer?
    private var milliseconds : Float = 50 * 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCardsLayout()
        game_COLVIEW_cardsCollection.delegate = self
        game_COLVIEW_cardsCollection.dataSource = self
        cards = model.createCards()
        gameTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
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
        if firstCardIndexPath == nil{
            firstCardIndexPath = indexPath
            firstCardFlipped = cards[indexPath.row]
            firstCardFlipped?.isFlipped = true
            cell.flip()
        }else if firstCardIndexPath != nil
            && secondCardIndexPath == nil{
            
            secondCardIndexPath = indexPath
            cell.flip()
            hasMatch(firstCardIndex: firstCardIndexPath!, secondCardIndex: secondCardIndexPath!)
                           if model.checkGameBoard() == true{
                               gameTimer?.invalidate()
                               viewAlertDialog(customMessage: "You have won the game!")
                           }
            
        }
       
    }
    
    
    
    // MARK: - Configuaration of main layout
    func configureCardsLayout() {
        let width = (view.frame.size.width - 40) / 4
        let layout = game_COLVIEW_cardsCollection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }


    // MARK: - Game logic
    
    func hasMatch(firstCardIndex : IndexPath, secondCardIndex : IndexPath) {
        // Update number of moves in the game
        updateMove()
        let cardOneCellView = game_COLVIEW_cardsCollection.cellForItem(at: firstCardIndex) as! CardCollectionViewCell
        let cardTwoCellView = game_COLVIEW_cardsCollection.cellForItem(at: secondCardIndex) as! CardCollectionViewCell
        let cardOne : Card = self.cards[firstCardIndex.row]
        let cardTwo : Card = self.cards[secondCardIndex.row]
        
        if cardOne.cardName == cardTwo.cardName {
            cardOne.isMatched = true
            cardTwo.isMatched = true
            cardOneCellView.remove()
            cardTwoCellView.remove()
            
        }else{
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            cardOneCellView.flipBack()
            cardTwoCellView.flipBack()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.3){
                self.firstCardIndexPath = nil
                self.secondCardIndexPath = nil
                       
                       }
        }
       
        
        
    }
    
    func updateMove() {
        self.countMoves = Int(game_LBL_moves.text!)!
        self.countMoves +=  1
        self.game_LBL_moves.text = String(countMoves)
    }
    
    
    // MARK: - Timer methods
    @objc func updateTimer() {
        milliseconds -= 1
        let seconds = String(format : "%.2f", milliseconds / 1000)
        self.game_LBL_timer.text = "Time Remaining: \(seconds)"
        if milliseconds <= 0{
            gameTimer?.invalidate()
            viewAlertDialog(customMessage: "You are not that fast")
        }
    }
    func viewAlertDialog(customMessage : String){
        let alert = UIAlertController(title: "Game Over", message: customMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
}

