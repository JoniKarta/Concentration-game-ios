//
//  ViewController.swift
//  Concentration-Game
//
//  Created by user165579 on 5/5/20.
//  Copyright © 2020 user165579. All rights reserved.
//

import UIKit
//UICollectionViewDelegateFlowLayout
class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate
{
    @IBOutlet weak var game_CV_cardscollection: UICollectionView!
    var cards : [Card] = [Card]()
    var model = CardModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCardsLayout()
        game_CV_cardscollection.delegate = self
        game_CV_cardscollection.dataSource = self
        cards = model.createCards()
        for card in cards {
            print(card.cardName)
        }

    }

    // MARK: - UICollectionView Protocol Methods
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return cards.count
       }
    
    func collectionView(_ collectionView:UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CardView", for: indexPath)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    }

    func configureCardsLayout() {
        let width = (view.frame.size.width - 40) / 4
        let layout = game_CV_cardscollection.collectionViewLayout as! UICollectionViewFlowLayout
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
}

