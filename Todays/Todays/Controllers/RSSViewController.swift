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
    
    var rssItems = [RSSFeedItemResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
        
        let cellNib = UINib(nibName: CellIdentifiers.RSSFeedItemCell , bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: CellIdentifiers.RSSFeedItemCell)
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
    
        let cell = tableView.dequeueReusableCell( withIdentifier: CellIdentifiers.RSSFeedItemCell, for: indexPath ) as! RSSFeedItemCell
    
        let item = rssItems[indexPath.row]
    
        cell.titleLabel.text = item.title
        cell.titleLabel.numberOfLines=0
    
        return cell
        }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if rssItems.count == 0 {
            return nil
        } else {
            return indexPath
        }
    }

}
