//
//  LaunchViewController.swift
//  Concentration-Game
//
//  Created by user165579 on 5/30/20.
//  Copyright © 2020 user165579. All rights reserved.
//

import UIKit
import CoreLocation


class LaunchViewController: UIViewController  {
    
    @IBOutlet weak var launch_TVIEW_name: UITextField!
    var locationManager: CLLocationManager!
    var converter : ConverterService = ConverterService()
    var userLocation : Location?
    var gameMode: String = "Easy"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyBoard()
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
        
        
    }
    
    @IBAction func launch_BTN_play(_ sender:Any) {
         let currentPlayerName =  launch_TVIEW_name.text!
               if currentPlayerName.isEmpty {
                   let alert = UIAlertController(title: "Error", message: "Please enter your name", preferredStyle: UIAlertController.Style.alert)
                   alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
        }
        self.performSegue(withIdentifier: "play_segue", sender: self)
        
        
        
    }
    
   
    // MARK: -  SUGUE PREPARATION
    @IBAction func launch_SEG_mode(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            gameMode = "Easy"
        }
        else if sender.selectedSegmentIndex == 1{
            gameMode = "Hard"
        }
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("inside prepare")
        if segue.identifier == "play_segue"{
            print("inside play")
            let destinationController = segue.destination as! ViewController
            destinationController.player.name = launch_TVIEW_name.text!
            destinationController.player.datePlayed = converter.dateFormatter(date: Date())
            destinationController.player.location = userLocation ?? Location()
            destinationController.selectedGameMode = gameMode
        }
        else if segue.identifier == "scores_segue" {
            let destinationController = segue.destination as! TopTenViewController
            // Give indication to launchViewController to activate the view without handling new player
            destinationController.viewActionContext = "display_score"
        }
    }
}

    // MARK: - LOCATION HANDLING
extension LaunchViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            userLocation = Location(lat: location.coordinate.latitude,lng: location.coordinate.longitude)
            print("Got the location")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error)")
    }
}
 
// MARK: - KEYBOARD HANDLING
extension LaunchViewController {
    func hideKeyBoard() {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(dismissKeyBoard))
        
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyBoard() {
        view.endEditing(true)
    }
    
}
