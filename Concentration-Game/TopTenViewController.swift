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
    @IBOutlet weak var topten_MAP_mapView: MKMapView!
    
    let cellReuseIdentifier = "custom_cell"
    var playerScores = [Player]()
    var currentPlayerPlayed : Player = Player()
    var converter: ConverterService = ConverterService()
    var viewActionContext: String = ""
    var place: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topten_LST_scores.delegate = self
        topten_LST_scores.dataSource = self
        //clearStroateTestingOnly()
        if(viewActionContext == "launch"){
            self.playerScores = readFromLocalStorage()
        }else{
            updateTableView(newPlayer: self.currentPlayerPlayed)
        }
        setMarkerOnMap(playerList:  self.playerScores)
    }
    
    // MARK: - MANGE STROAGE
    
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
    
    
    // MARK: - MANGE TABLE VIEW
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

// MARK: - PROTOCOL FOR MANGE TABLE-VIEW
extension TopTenViewController :UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : CustomEntryCell? = self.topten_LST_scores.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? CustomEntryCell
        cell?.topten_LBL_playername?.text = self.playerScores[indexPath.row].name
        cell?.topten_LBL_playertime?.text = String(format:"%02i:%02i", self.playerScores[indexPath.row].score/60,self.playerScores[indexPath.row].score % 60)
        cell?.topten_LBL_playerdate?.text = self.playerScores[indexPath.row].datePlayed
        if(cell == nil){
            cell = CustomEntryCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellReuseIdentifier)
        }
        return cell!
    }
    
    
    // MARK: - MANAGE MAP
    func setMarkerOnMap(playerList: [Player]){
        if(!playerList.isEmpty){
            for player in playerList {
                let annontation = MKPointAnnotation()
                annontation.title = player.name
                annontation.coordinate = CLLocationCoordinate2D(latitude: player.location.lat , longitude: player.location.lng )
                topten_MAP_mapView.addAnnotation(annontation)
            }
            zoomIn(winner: playerList.first!)
        }
    }
    
    func zoomIn(winner: Player){
        let zoomIn = CLLocationCoordinate2D(latitude: winner.location.lat , longitude:winner.location.lng  )
        let region = MKCoordinateRegion(center: zoomIn, latitudinalMeters: 800, longitudinalMeters: 800)
        topten_MAP_mapView.setRegion(region, animated: true)    }
    // MARK: - TESTING
    
    func clearStroateTestingOnly(){
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        
    }}




class CustomEntryCell: UITableViewCell {
    @IBOutlet weak var topten_LBL_playername: UILabel!
    @IBOutlet weak var topten_LBL_playertime: UILabel!
    @IBOutlet weak var topten_LBL_playerdate: UILabel!
}




