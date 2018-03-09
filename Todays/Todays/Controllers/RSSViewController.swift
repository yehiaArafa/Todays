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
    
    var rssItems = [RSSFeedItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData(){
        let feedParser = XMLFeedParser()
        feedParser.parseFeed(url: "https://news.google.com/news/rss/local/section/geo/Las%20Cruces,%20NM,%20USA/Las%20Cruces,%20New%20Mexico?ned=us&hl=en&gl=US"){
            (items) in
            self.rssItems = items
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
    }

}

// MARK: - Table view data source

extension RSSViewController: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rssItems.count
    }
    
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "RssFeedCell"
    
        var cell:UITableViewCell! = tableView.dequeueReusableCell( withIdentifier: cellIdentifier)
    
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
    
            let tittleLabel = cell.viewWithTag(100) as! UILabel
            //let descriptionLabel = cell.viewWithTag(101) as! UILabel
    
            let item = rssItems[indexPath.row]
            tittleLabel.text = item.title
            tittleLabel.numberOfLines = 0
            //descriptionLabel.numberOfLines = 0
            //descriptionLabel.text = "item.description"
    
            return cell
        }
}
