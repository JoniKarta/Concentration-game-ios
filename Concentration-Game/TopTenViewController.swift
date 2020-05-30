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

    var testArray: [String] = ["cat", "dog", "lion", "bear", "elephant", "tiger", "monkey"]
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topten_LST_scores.delegate = self
        topten_LST_scores.dataSource = self
        self.topten_LST_scores.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = self.topten_LST_scores.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
        cell?.textLabel?.text = self.testArray[indexPath.row]
        if(cell == nil){
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellReuseIdentifier	)
        }
        return cell!
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
