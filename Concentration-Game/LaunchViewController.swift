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
        }
    }
    
   
  

}
