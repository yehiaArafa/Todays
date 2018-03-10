//
//  RSSViewController.swift
//  Todays
//
//  Created by Yehia Arafa on 3/9/18.
//  Copyright © 2018 Yehia Arafa. All rights reserved.
//

import UIKit

class RSSViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var isLoading = false
    
    var rssItems = [RSSFeedItemResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        
        fetchData(to: segmentedControl.selectedSegmentIndex)
        
        registerTheNibs()
    }
    
    
    func registerTheNibs(){
        var cellNib = UINib(nibName: CellIdentifiers.RSSFeedItemCell , bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: CellIdentifiers.RSSFeedItemCell)
        
        cellNib = UINib(nibName: CellIdentifiers.loadingFeedCell , bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: CellIdentifiers.loadingFeedCell)
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
          myUrl = lasCrucesRSS.general
        case 1:
            myUrl = lasCrucesRSS.sports
        case 2:
            myUrl = lasCrucesRSS.politics
        case 3:
            myUrl = lasCrucesRSS.economics
        default:
            myUrl = lasCrucesRSS.general
        }
        
       
        let net = Networking()
        let url = net.prepareURL(urlString: myUrl)
        
        let feedParser = XMLFeedParser()
        feedParser.parseFeed(url: url){
            (items) in
            self.rssItems = items
            OperationQueue.main.addOperation {
                self.isLoading = false
                self.tableView.reloadData()
            }
        }
    }
}


// MARK: - Table view data source

extension RSSViewController: UITableViewDelegate, UITableViewDataSource {

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
    
        cell.titleLabel.text = item.title
        cell.titleLabel.numberOfLines=0
    
        return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if rssItems.count == 0 || isLoading {
            return nil
        } else {
            return indexPath
        }
    }

}
