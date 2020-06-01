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
    var userLocation : Location?
    var gameMode: String = "Easy"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
        
    }
    
    @IBAction func launch_SEG_mode(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            // easy mode
            gameMode = "Easy"
            print("Easy mode pressed")
        }
        else if sender.selectedSegmentIndex == 1{
            // hard mode
            gameMode = "Hard"
            print("Hard mode pressed")

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "play_segue"{
            let destinationController = segue.destination as! ViewController
            destinationController.player.name = launch_TVIEW_name.text!
            destinationController.player.datePlayed = dateFormatter()
            destinationController.player.location = userLocation ?? Location()
            destinationController.selectedGameMode = gameMode
        }
        else if segue.identifier == "scores_segue" {
            let destinationController = segue.destination as! TopTenViewController
            destinationController.viewActionContext = "launch"
        }
    }
    
    func dateFormatter() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        return formatter.string(from: currentDate)
        
    }
    
    
}

extension LaunchViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            userLocation = Location(lat: location.coordinate.latitude,lng: location.coordinate.longitude)
            
        }
        print("got location")
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error)")
    }
}
