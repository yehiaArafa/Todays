//
//  SideMenuTableViewController.swift
//  Todays
//
//  Created by Yehia Arafa on 3/11/18.
//  Copyright © 2018 Yehia Arafa. All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController {

   var sideMenuOptions = [String]()
   var currentCity = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuOptions.append(sideMenuContsants.firstSelection)
        sideMenuOptions.append(sideMenuContsants.secondSelection)
        sideMenuOptions.append(sideMenuContsants.thirdSelection)
        sideMenuOptions.append(sideMenuContsants.fourthSelection)
    }

 
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuOptions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuSelectionCell", for: indexPath)
        
        let label = cell.viewWithTag(1001) as! UILabel
        label.text = sideMenuOptions[indexPath.row]
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if (indexPath.row == 0){
            performSegue(withIdentifier: "FeedSegue", sender: RSSFeedItemCell.self)
        }
        else if (indexPath.row == 1){
            performSegue(withIdentifier: "RestaurantsSegue", sender: RSSFeedItemCell.self)
        }
        else if (indexPath.row == 2){
            performSegue(withIdentifier: "PicsSegue", sender: RSSFeedItemCell.self)
        }
        else if (indexPath.row == 3){
            performSegue(withIdentifier: "WeatherSegue", sender: RSSFeedItemCell.self)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if sideMenuOptions.count == 0 {
            return nil
        } else {
            return indexPath
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "WeatherSegue") {
            let destinationNavigationController = segue.destination as! weatherViewController
            destinationNavigationController.currentCity = currentCity
            
        }
        if (segue.identifier == "FeedSegue") {
            let destinationNavigationController = segue.destination as! RSSFeedViewController
            destinationNavigationController.currentCity = currentCity
            
        }
        
    }

}
