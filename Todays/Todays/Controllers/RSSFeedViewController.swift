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
    
    var isLoading = false
    
    var rssItems = [RSSFeedItemResult]()
    var currentLink = ""
    var networkManager = Networking()
    
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
        performSegue(withIdentifier: "ArticleDetails", sender: RSSFeedItemCell.self)
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
        if segue.identifier == "ArticleDetails" {
            let controller = segue.destination as! ArticleDetailsViewController
            controller.delegate = self
            let url = networkManager.prepareURL(urlString: currentLink)
            let request = networkManager.performRequest(from: url)
            controller.articleURL = request
        }
    }
    
    
}
    

