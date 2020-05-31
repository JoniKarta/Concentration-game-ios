//
//  TopTenViewController.swift
//  Concentration-Game
//
//  Created by user165579 on 5/30/20.
//  Copyright © 2020 user165579. All rights reserved.
//

import UIKit
import MapKit

class TopTenViewController: UIViewController{
   
    @IBOutlet weak var topten_LST_scores: UITableView!
    @IBOutlet weak var toten_MAP_mapView: MKMapView!
    
    var playerScores = [Player]()
    var currentPlayerPlayed : Player = Player()
    let cellReuseIdentifier = "custom_cell"
    var converter: ConverterService = ConverterService()

    override func viewDidLoad() {
        super.viewDidLoad()
        clearStroateTestingOnly()
        displayTableView()
        addMarkerToMap(playerList:  self.playerScores)
        for item in self.playerScores {
            print(item)
        }
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
        if let newList: [Player] = converter.jsonToPlayerList(jsonPlayerList: defaults.string(forKey: "test") ?? ""){
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
    
    func clearStroateTestingOnly(){
        let domain = Bundle.main.bundleIdentifier!
               UserDefaults.standard.removePersistentDomain(forName: domain)
               UserDefaults.standard.synchronize()
               
    }
    
    func addMarkerToMap(playerList: [Player]){
        var annontation : MKPointAnnotation!
        for player in playerList {
            annontation = MKPointAnnotation()
            annontation.coordinate = CLLocationCoordinate2D(latitude: player.location.lat, longitude: player.location.lng)
            annontation.title = player.name
            toten_MAP_mapView.addAnnotation(annontation)
        }
        
        let region = MKCoordinateRegion(center: annontation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        toten_MAP_mapView.setRegion(region, animated: true)
    }
  
}
class CustomEntryCell: UITableViewCell {
    @IBOutlet weak var topten_LBL_playername: UILabel!
    @IBOutlet weak var topten_LBL_playertime: UILabel!
    @IBOutlet weak var topten_LBL_playerdate: UILabel!
}
