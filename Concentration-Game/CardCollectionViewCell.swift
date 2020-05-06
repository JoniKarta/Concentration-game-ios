//
//  CardCollectionViewCell.swift
//  Concentration-Game
//
//  Created by user165579 on 5/5/20.
//  Copyright © 2020 user165579. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var game_IMG_backcard: UIImageView!
    @IBOutlet weak var game_IMG_frontcard: UIImageView!
    
    var card : Card?
    
    func setCard(_ card: Card){
        self.card = card
        
        self.game_IMG_frontcard.image = UIImage(named: card.cardName)
    }
    
    func flip() {
        UIView.transition(from: self.game_IMG_backcard,
                          to: self.game_IMG_frontcard,
                          duration: 0.3,
                          options: [.transitionFlipFromLeft,.showHideTransitionViews],
                          completion: nil)
    }
    
    func flipBack() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0){
            UIView.transition(from: self.game_IMG_frontcard ,
                              to: self.game_IMG_backcard,
                duration: 0.3,
                options: [.transitionFlipFromRight,.showHideTransitionViews],
                completion: nil)
        }
    }
    
    func remove() {
        self.game_IMG_backcard.alpha = 0
        UIView.animate(withDuration: 0.3,
                       delay: 0.5,
                       options: .curveLinear,
                       animations: {
                        self.game_IMG_frontcard.alpha = 0
        }, completion: nil)
    }
}
