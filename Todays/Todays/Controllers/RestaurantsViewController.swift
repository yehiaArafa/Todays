//
//  RestaurantsViewController.swift
//  Todays
//
//  Created by Yehia Arafa on 3/11/18.
//  Copyright © 2018 Yehia Arafa. All rights reserved.
//

import UIKit

class RestaurantsViewController: UIViewController {

    var currentCity = 0
    @IBOutlet weak var tableView: UITableView!
    let net = Networking()
    var resturantsResults = [RestuaurantsItemResult]()
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTheNibs()
        fetchData()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 118
        tableView.allowsSelection = false;
        setNavigationBarTitle()
    }
    
    func registerTheNibs(){
        var cellNib = UINib(nibName: CellIdentifiers.RestaurantsCell , bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: CellIdentifiers.RestaurantsCell)
        
        cellNib = UINib(nibName: CellIdentifiers.loadingFeedCell , bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: CellIdentifiers.loadingFeedCell)
    }
    
    func setNavigationBarTitle(){
        switch currentCity{
        case 0:
            self.title = "Las Cruces Restaurants"
        case 1:
            self.title = "El Paso Restaurants"
        case 2:
            self.title = "Albuquerque Restaurants"
        default:
            self.title = "Restaurants"
        }
    }
    
    func fetchData(){
        
        isLoading = true
        tableView.reloadData()

        var url:URL!
        if (currentCity == 0){
            url = net.prepareURL(urlString: Restuaurants.lasCruces)
        }
        else if (currentCity == 1){
            url = net.prepareURL(urlString: Restuaurants.elpaso)
        }
        else if(currentCity == 2){
            url = net.prepareURL(urlString: Restuaurants.albuquerque)
        }
        
        var request = URLRequest(url: url)
        request.addValue(YelpApikey, forHTTPHeaderField: "Authorization")
        
        var dataTask: URLSessionDataTask?
        let session = URLSession.shared
        
        dataTask = session.dataTask(with: request, completionHandler:
            { data, response, error in
                if let data = data {
                    self.resturantsResults = self.parse(data: data)
                    self.resturantsResults.sort(by: >)
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.tableView.reloadData()
                    }
                    return
                } else {
                    print("Failure! \(response!)")
                }
        })
        
        dataTask?.resume()
    }

    
    /* parse the jason response */
    func parse(data: Data) ->[RestuaurantsItemResult] {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(RestuaurantsItemResultArray.self, from:data)
            return result.businesses
        } catch {
            print("JSON Error: \(error)")
            return []
        }
    }
    
   // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ShowMenuFromRestuarantsSegue"){
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! SideMenuTableViewController
            targetController.currentCity = currentCity
        }
    }
    
}

// MARK: - Table View Delegates

extension RestaurantsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading{
            return 1
        }
        return resturantsResults.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.loadingFeedCell, for: indexPath)
            
            let spinner = cell.viewWithTag(101) as! UIActivityIndicatorView
            spinner.startAnimating()
            return cell
        }
        else{
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.RestaurantsCell, for: indexPath) as! RestuaurantsCell
        let restuaurantsItem = resturantsResults[indexPath.row]
        cell.setLabels(for: restuaurantsItem)
        return cell

//        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.RestaurantsCell, for: indexPath)
//        return cell
    
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if (resturantsResults.count == 0 || isLoading) {
            return nil
        } else {
            return indexPath
        }
    }
}
