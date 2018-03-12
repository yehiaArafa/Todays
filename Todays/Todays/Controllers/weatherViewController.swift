//
//  weatherViewController.swift
//  Todays
//
//  Created by Yehia Arafa on 3/11/18.
//  Copyright © 2018 Yehia Arafa. All rights reserved.
//

import UIKit

class weatherViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var networkManager = Networking()
    var weatherItem = WeatherCityResult()
    var currentCity = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.rowHeight = 500
        registerTheNibs()
        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
      
        super.viewWillAppear(animated)
        
        // Add a background view to the table view
        let backgroundImage = UIImage(named: "Organ_Mountains")
        let imageView = UIImageView(image: backgroundImage)
        tableView.backgroundView = imageView
    }
    
    func registerTheNibs(){
        let cellNib = UINib(nibName: CellIdentifiers.WeatherCell , bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: CellIdentifiers.WeatherCell)
        
    }


    func fetchData(){
        
        let url: URL
        
        switch currentCity {
        case 0:
             url = networkManager.prepareURL(urlString: weatherAPI.lasCruces)
        case 1:
            url = networkManager.prepareURL(urlString: weatherAPI.elPaso)
        case 2:
            url = networkManager.prepareURL(urlString: weatherAPI.albuquerque)
        default:
            url = networkManager.prepareURL(urlString: weatherAPI.lasCruces)
        }
       
        
        let feedParser = XMLWeatherParser()
        feedParser.parseFeed(url: url){
            (item) in
            self.weatherItem = item
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }


}


extension weatherViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.WeatherCell, for: indexPath) as! WeatherCell
        cell.setLabel(currentCity: weatherItem.cityName, currentIcon: "icon", currentWeather: weatherItem.temperature_f)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if(segue.identifier == "ShowMenuFromWeatherSegue"){
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! SideMenuTableViewController
            targetController.currentCity = currentCity
        }
    }
    

}
