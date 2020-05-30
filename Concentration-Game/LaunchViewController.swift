//
//  LaunchViewController.swift
//  Concentration-Game
//
//  Created by user165579 on 5/30/20.
//  Copyright © 2020 user165579. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var launch_TVIEW_name: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "play_segue" {
            let destinationController = segue.destination as! ViewController
            destinationController.player.playerName = launch_TVIEW_name.text!
            destinationController.player.playerPlayDate = dateFormatter()
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
