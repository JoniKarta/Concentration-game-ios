//
//  TopTenViewController.swift
//  Concentration-Game
//
//  Created by user165579 on 5/30/20.
//  Copyright © 2020 user165579. All rights reserved.
//

import UIKit

class TopTenViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{
   
    @IBOutlet weak var topten_LST_scores: UITableView!

    var playerScores = [Player]()
    
    let cellReuseIdentifier = "custom_cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topten_LST_scores.delegate = self
        topten_LST_scores.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        createTestPlayerList()
        return playerScores.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : CustomEntryCell? = self.topten_LST_scores.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? CustomEntryCell
        cell?.topten_LBL_playername?.text = self.playerScores[indexPath.row].playerName
        cell?.topten_LBL_playertime?.text = self.playerScores[indexPath.row].playerScore
        cell?.topten_LBL_playerdate?.text = self.playerScores[indexPath.row].playerPlayDate
        
        if(cell == nil){
            cell = CustomEntryCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellReuseIdentifier	)
        }
        return cell!
    }
    
    func createTestPlayerList() {
        self.playerScores.append(Player(playerName: "Jonathan",playerScore: "2:04",playerPlayDate: "Some date"))
        self.playerScores.append(Player(playerName: "Nisim",playerScore: "3:04",playerPlayDate: "antoher date"))
        self.playerScores.append(Player(playerName: "Ron",playerScore: "4:04",playerPlayDate: "Another date"))
        self.playerScores.append(Player(playerName: "David",playerScore: "5:04",playerPlayDate: "Some date"))
        
    }
}
class CustomEntryCell: UITableViewCell {
    @IBOutlet weak var topten_LBL_playername: UILabel!
    @IBOutlet weak var topten_LBL_playertime: UILabel!
    @IBOutlet weak var topten_LBL_playerdate: UILabel!
}
