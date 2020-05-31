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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "play_segue"{
            let destinationController = segue.destination as! ViewController
            destinationController.player.name = launch_TVIEW_name.text!
            destinationController.player.datePlayed = dateFormatter()
            destinationController.player.location = userLocation ?? Location()
        }
    }
    
    // TODO CHANGE THE LOCATION OF THIS FUNCTION TO THE CORRECT PLACE
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
