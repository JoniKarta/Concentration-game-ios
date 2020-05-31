//
//  TopTenViewController.swift
//  Concentration-Game
//
//  Created by user165579 on 5/30/20.
//  Copyright © 2020 user165579. All rights reserved.
//

import UIKit

class TopTenViewController: UIViewController{
   
    @IBOutlet weak var topten_LST_scores: UITableView!

    var playerScores = [Player]()
    var currentPlayerPlayed : Player = Player()
    let cellReuseIdentifier = "custom_cell"
    var converter: ConverterService = ConverterService()
    override func viewDidLoad() {
        super.viewDidLoad()
        createTestPlayerList()
//        print("Player details Game: \(currentPlayerPlayed.name) \(currentPlayerPlayed.score) \(currentPlayerPlayed.datePlayed)")
        topten_LST_scores.delegate = self
        topten_LST_scores.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    func createTestPlayerList() {
        self.playerScores.append(Player(playerName: "Jonathan",playerScore: 2.04,playerPlayDate: "Some date"))
        self.playerScores.append(Player(playerName: "Nisim",playerScore: 3.04,playerPlayDate: "antoher date"))
        self.playerScores.append(Player(playerName: "Ron",playerScore: 4.94,playerPlayDate: "Another date"))
        self.playerScores.append(Player(playerName: "David",playerScore: 5.704,playerPlayDate: "Some date"))
       let newData = converter.playerListToJson(playerList: self.playerScores)
        let listFromStorage : [Player] = converter.jsonToPlayerList(jsonPlayerList: newData) ?? [Player]()
        for item in listFromStorage {
            print("\(item)")
        }
    }
}
extension TopTenViewController :UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return playerScores.count
         }
         
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          var cell : CustomEntryCell? = self.topten_LST_scores.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? CustomEntryCell
          cell?.topten_LBL_playername?.text = self.playerScores[indexPath.row].name
          cell?.topten_LBL_playertime?.text = String(self.playerScores[indexPath.row].score)
          cell?.topten_LBL_playerdate?.text = self.playerScores[indexPath.row].datePlayed
          
          if(cell == nil){
              cell = CustomEntryCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellReuseIdentifier    )
          }
          return cell!
      }
    
    func savePlayerToStorage(){
        
    }
    
    func readPlayerFromStorage() {
        
    }
      
}
class CustomEntryCell: UITableViewCell {
    @IBOutlet weak var topten_LBL_playername: UILabel!
    @IBOutlet weak var topten_LBL_playertime: UILabel!
    @IBOutlet weak var topten_LBL_playerdate: UILabel!
}
