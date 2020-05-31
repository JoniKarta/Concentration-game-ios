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
    private var gameModel = GameModel()
    private var countMoves : Int = 0
    private var firstCardFlipped : IndexPath?
    private var secondCardFlipped : IndexPath?
    private var gameTimer : Timer?
    private var milliseconds : Float = 0 * 1000
    var player: Player = Player()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCardsLayout()
        game_COLVIEW_cardsCollection.delegate = self
        game_COLVIEW_cardsCollection.dataSource = self
        cards = gameModel.createCards()
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
        if firstCardFlipped == nil{
            cell.flip()
            firstCardFlipped = indexPath
            cards[self.firstCardFlipped!.row].isFlipped = true
            
        }else if cards[indexPath.row].isFlipped == false // it's not the same card
            && secondCardFlipped == nil{ // second card not get flippled
            cell.flip()
            secondCardFlipped = indexPath
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.9){
                self.firstCardFlipped = nil
                self.secondCardFlipped = nil
            }
            hasMatch(firstCardIndex: self.firstCardFlipped!, secondCardIndex: self.secondCardFlipped!)
            if gameModel.checkGameBoard() == true{
                gameTimer?.invalidate()
                player.score = milliseconds / 1000
                self.performSegue(withIdentifier: "segue_game_scores", sender: self)

            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_game_scores" {
            let destinationController = segue.destination as! TopTenViewController
            destinationController.currentPlayerPlayed = player
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
            // FOR TESTING ONLY
             player.score =  milliseconds / 1000
            self.performSegue(withIdentifier: "segue_game_scores", sender: self)
        }else{
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            cardOneCellView.flipBack()
            cardTwoCellView.flipBack()
        }
    }
    
    func updateMove() {
        self.countMoves = Int(game_LBL_moves.text!)!
        self.countMoves +=  1
        self.game_LBL_moves.text = String(countMoves)
    }
    
    
    // MARK: - Timer methods
    @objc func updateTimer(){
        milliseconds += 1
        let seconds = String(format : "%.2f", milliseconds / 1000)
        self.game_LBL_timer.text = "Time Passed: \(seconds)"
    }
    func viewAlertDialog(customMessage : String){
        let alert = UIAlertController(title: "Game Over", message: customMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    
}

