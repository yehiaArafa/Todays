//
//  RSSViewController.swift
//  Todays
//
//  Created by Yehia Arafa on 3/9/18.
//  Copyright © 2018 Yehia Arafa. All rights reserved.
//

import UIKit



class RSSFeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    var currentCity: Int = 0
    var didSelectNMSU = false
    var isLoading = false
    var rssItems = [RSSFeedItemResult]()
    var currentLink = ""
    var networkManager = Networking()
  

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 118
        tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        registerTheNibs()
        fetchData(to: segmentedControl.selectedSegmentIndex)
        if (didSelectNMSU){
            replaceSegments()
            self.title = "NMSU News Feed"
        }
        
        
    }
    
    func registerTheNibs(){
        var cellNib = UINib(nibName: CellIdentifiers.RSSFeedItemCell , bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: CellIdentifiers.RSSFeedItemCell)
        
        cellNib = UINib(nibName: CellIdentifiers.loadingFeedCell , bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: CellIdentifiers.loadingFeedCell)
    }
    
    func replaceSegments() {
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "General", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Student", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Sports", at: 2, animated: false)
        segmentedControl.selectedSegmentIndex = 0
    }
    
   
    @IBAction func selectSegment(_ sender: Any) {
        fetchData(to: segmentedControl.selectedSegmentIndex)
    }
    

    func fetchData(to section: Int){
        
        isLoading = true
        tableView.reloadData()
        
        var myUrl : String
        
        switch section {
        case 0:
            if (didSelectNMSU){
                myUrl = NMSURSS.general
                break
            }
          switch currentCity{
            case 0:
                myUrl = lasCrucesRSS.general
            case 1:
                myUrl = elPasoRSS.general
            case 2:
                myUrl = albuquerqueRSS.general
            default:
                 myUrl = ""
                }
        case 1:
            if (didSelectNMSU){
                myUrl = NMSURSS.student
                break
            }
            switch currentCity{
            case 0:
                myUrl = lasCrucesRSS.sports
            case 1:
                myUrl = elPasoRSS.sports
            case 2:
                myUrl = albuquerqueRSS.sports
            default:
                 myUrl = ""
            }
        case 2:
            if (didSelectNMSU){
                myUrl = NMSURSS.sports
                break
            }
            else{
            switch currentCity{
            case 0:
                myUrl = lasCrucesRSS.politics
            case 1:
                myUrl = elPasoRSS.politics
            case 2:
                myUrl = albuquerqueRSS.politics
            default:
                 myUrl = ""
            }
        }
        case 3:
            switch currentCity{
            case 0:
                myUrl = lasCrucesRSS.economics
            case 1:
                myUrl = elPasoRSS.economics
            case 2:
                myUrl = albuquerqueRSS.economics
            default:
                myUrl = ""
            }
        default:
            myUrl = ""
        }
        
        
        let url = networkManager.prepareURL(urlString: myUrl)
        
        let feedParser = XMLFeedParser()
        feedParser.parseFeed(url: url){
            (items) in
            self.rssItems = items
            DispatchQueue.main.async {
                self.isLoading = false
                self.tableView.reloadData()
            }
        }
    }

  

}


// MARK: - Table view data source

extension RSSFeedViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isLoading{
            return 1
        }
        return rssItems.count
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if isLoading {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.loadingFeedCell, for: indexPath)
            
            let spinner = cell.viewWithTag(101) as! UIActivityIndicatorView
            spinner.startAnimating()
            return cell
        }
        else{
    
        let cell = tableView.dequeueReusableCell( withIdentifier: CellIdentifiers.RSSFeedItemCell, for: indexPath ) as! RSSFeedItemCell
    
        let item = rssItems[indexPath.row]
    
        cell.setLabels(for: item)
    
        return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         currentLink = rssItems[indexPath.row].link
        if(didSelectNMSU && segmentedControl.selectedSegmentIndex == 0){
           currentLink = currentLink.components(separatedBy: .whitespacesAndNewlines).joined()
        }
        performSegue(withIdentifier: "ArticleDetailsSegue", sender: RSSFeedItemCell.self)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if rssItems.count == 0 || isLoading {
            return nil
        } else {
            return indexPath
        }
    }

}

// MARK: - Table view ArticleDetails Delegate

extension RSSFeedViewController: ArticleDetailsViewControllerDelegate{
    
    func cancel(_ controller: ArticleDetailsViewController) {
        navigationController?.popViewController(animated:true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ArticleDetailsSegue") {
            let controller = segue.destination as! ArticleDetailsViewController
            controller.delegate = self
            
            let url = networkManager.prepareURL(urlString: currentLink)
            
            let request = networkManager.performRequest(from: url)
            controller.articleURL = request
        }
        else if(segue.identifier == "ShowMenuFromNewsFeedSegue"){
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! SideMenuTableViewController
            targetController.currentCity = currentCity
        }
    }
    
    
}


    

