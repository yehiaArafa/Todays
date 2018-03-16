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
    @IBOutlet weak var tabBar: UITabBar!
    
    var networkManager = Networking()
    var weatherItem = WeatherCityResult()
    var currentCity = 0
    var isCelsius = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView.tableFooterView = UIView()
        weatherTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        registerTheNibs()
        weatherTableView.allowsSelection = false;
        fetchData()
        weatherTableView.contentInset = UIEdgeInsets(top: weatherTableView.bounds.height / 3, left: 0 , bottom: 0, right: 0)
        setNavigationBarTitle()
        
        tabBar.selectedItem = tabBar.items![1]
       
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
    
    func setNavigationBarTitle(){
        switch currentCity{
        case 0:
            self.title = "Las Cruces Weather"
        case 1:
            self.title = "El Paso Weather"
        case 2:
            self.title = "Albuquerque Weather"
        default:
            self.title = "Weather"
        }
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.WeatherCell, for: indexPath) as! WeatherCell
        cell.setLabels(for: weatherItem, currentCity: currentCity, celsius: isCelsius)

        return cell
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.WeatherCell, for: indexPath)
//
//        return cell
//    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(red:220/250, green:220/250, blue:220/250, alpha: 0.2)
        //cell.layer.backgroundColor = UIColor.clear.cgColor
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //let tHeight = tableView.bounds.height / 2
        return 120
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ShowMenuFromWeatherSegue"){
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! SideMenuTableViewController
            targetController.currentCity = currentCity
        }
    }
    

}

extension weatherViewController: UITabBarDelegate{
    
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if(item.tag == 105){
            isCelsius = false
            weatherTableView.reloadData()
        }
        else{
            isCelsius = true
            weatherTableView.reloadData()
        }
        
    }
    
}
