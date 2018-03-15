//
//  weatherViewController.swift
//  Todays
//
//  Created by Yehia Arafa on 3/11/18.
//  Copyright © 2018 Yehia Arafa. All rights reserved.
//

import UIKit

class weatherViewController: UIViewController {


    @IBOutlet weak var weatherTableView: UITableView!
    
    var networkManager = Networking()
    var weatherItem = WeatherCityResult()
    var currentCity = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView.tableFooterView = UIView()
        weatherTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        registerTheNibs()
        //fetchData()
         weatherTableView.contentInset = UIEdgeInsets(top: weatherTableView.bounds.height / 3 - 40, left: 0 , bottom: 0, right: 20)
    }

    override func viewWillAppear(_ animated: Bool) {
      
        super.viewWillAppear(animated)
        var backgroundImage = UIImage(named: "las_cruces")
        
        if (currentCity == 0){
            backgroundImage = UIImage(named: "las_cruces")
        }
        else if(currentCity == 1){
            backgroundImage = UIImage(named: "elpaso")
        }
        else if(currentCity == 2){
            backgroundImage = UIImage(named: "albaqurque")
        }

        let imageView = UIImageView(image: backgroundImage)
        weatherTableView.backgroundView = imageView
        
    }
    
    func registerTheNibs(){
        let cellNib = UINib(nibName: CellIdentifiers.WeatherCell , bundle: nil)
        weatherTableView.register(cellNib, forCellReuseIdentifier: CellIdentifiers.WeatherCell)
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
       
        
        let parser = XMLWeatherParser()
        parser.parseWeather(url: url){
            (item) in
            self.weatherItem = item
            DispatchQueue.main.async {
                self.weatherTableView.reloadData()
            }
        }
    }


}


extension weatherViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.WeatherCell, for: indexPath) as! WeatherCell
//        cell.setLabel(currentCity: weatherItem.cityName, currentIconLink: weatherItem.iconLink , currentWeather: weatherItem.temperature_f)
//
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.WeatherCell, for: indexPath)

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(red:0.752, green:0.752, blue:0.752, alpha: 0.5)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //let tHeight = tableView.bounds.height / 2
        return 252
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ShowMenuFromWeatherSegue"){
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! SideMenuTableViewController
            targetController.currentCity = currentCity
        }
    }
    

}
