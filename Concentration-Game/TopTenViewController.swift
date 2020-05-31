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
        displayTableView()
        topten_LST_scores.delegate = self
        topten_LST_scores.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    func displayTableView() {
        
        updateTableView(newPlayer: self.currentPlayerPlayed)
    }
    func writeToLocalStorage(playersList: [Player]){
        let defaults = UserDefaults.standard
        defaults.set(converter.playerListToJson(playerList: playersList), forKey: "test")
    }
    
    func readFromLocalStorage() -> [Player]{
        let defaults = UserDefaults.standard
        if let newList: [Player] = converter.jsonToPlayerList(jsonPlayerList: defaults.string(forKey: "test")!){
           return newList
        }
        return [Player]()
    }
    func updateTableView(newPlayer: Player){
        var playerListFromStorage = readFromLocalStorage()
        if playerListFromStorage.count < 10 {
            playerListFromStorage.append(newPlayer)
            writeToLocalStorage(playersList: playerListFromStorage.sorted(by: {$0.score < $1.score}))
        }else if(playerListFromStorage.last!.score > newPlayer.score){
            playerListFromStorage.remove(at: playerListFromStorage.count - 1)
            playerListFromStorage.append(newPlayer)
            writeToLocalStorage(playersList: playerListFromStorage.sorted(by: {$0.score < $1.score}))
        }
        self.playerScores = readFromLocalStorage()

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
