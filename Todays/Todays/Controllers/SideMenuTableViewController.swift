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
    var didSelectNMSU = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMenuOptions()
    }

    func addMenuOptions(){
        sideMenuOptions.append(sideMenuContsants.localNews)
        if(currentCity == 0){
            sideMenuOptions.append(sideMenuContsants.NMSU)
        }
        sideMenuOptions.append(sideMenuContsants.localResturants)
        sideMenuOptions.append(sideMenuContsants.localWeather)
        //sideMenuOptions.append(sideMenuContsants.localPics)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuOptions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuSelectionCell", for: indexPath)
        
        let label = cell.viewWithTag(1001) as! UILabel
        label.font = UIFont(name: "Avenir-BlackOblique", size: 18)!
        label.text = sideMenuOptions[indexPath.row]
        let labelIm = cell.viewWithTag(110) as! UIImageView
        
        switch sideMenuOptions[indexPath.row]{
        case sideMenuContsants.localWeather:
             labelIm.image = UIImage(named: "temperature")
        case sideMenuContsants.localNews:
            labelIm.image = UIImage(named: "newspaper")
        case sideMenuContsants.localResturants:
            labelIm.image = UIImage(named: "food")
        case sideMenuContsants.NMSU:
            labelIm.image = UIImage(named: "NMState")
        default:
             labelIm.image = UIImage(named: "ImagePlaceHolder")
        }
       
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(red: 140/255, green: 11/255, blue: 66/255, alpha: 1)
        cell.selectedBackgroundView = selectedView
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch sideMenuOptions[indexPath.row] {
        case sideMenuContsants.localNews:
            performSegue(withIdentifier: "FeedSegue", sender: RSSFeedItemCell.self)
        case sideMenuContsants.NMSU:
            didSelectNMSU = true
            performSegue(withIdentifier: "FeedSegue", sender: RSSFeedItemCell.self)
        case sideMenuContsants.localResturants:
            performSegue(withIdentifier: "RestaurantsSegue", sender: RSSFeedItemCell.self)
        case sideMenuContsants.localWeather:
             performSegue(withIdentifier: "WeatherSegue", sender: RSSFeedItemCell.self)
        case sideMenuContsants.localPics:
            performSegue(withIdentifier: "PicsSegue", sender: RSSFeedItemCell.self)
        default:
            return
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if sideMenuOptions.count == 0 {
            return nil
        } else {
            return indexPath
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "WeatherSegue") {
            let destinationNavigationController = segue.destination as! weatherViewController
            destinationNavigationController.currentCity = currentCity
        }
        else if (segue.identifier == "FeedSegue") {
            let destinationNavigationController = segue.destination as! RSSFeedViewController
            destinationNavigationController.currentCity = currentCity
            if(didSelectNMSU){
                destinationNavigationController.didSelectNMSU = true
            }
        }
        else if (segue.identifier == "RestaurantsSegue") {
            let destinationNavigationController = segue.destination as! RestaurantsViewController
            destinationNavigationController.currentCity = currentCity
        }
    }

}
