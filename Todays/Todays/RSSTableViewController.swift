//
//  RSSTableViewController.swift
//  Todays
//
//  Created by Yehia Arafa on 3/9/18.
//  Copyright © 2018 Yehia Arafa. All rights reserved.
//

import UIKit

class RSSTableViewController: UITableViewController {

    var rssItems: [RSSItem]?
    
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
                self.tableView.reloadSections(IndexSet(integer: 0), with: .left)
            }
            
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = rssItems else{
            return 0
        }
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RssFeedCell", for: indexPath)
      
        let tittleLabel = cell.viewWithTag(100) as! UILabel
        let descriptionLabel = cell.viewWithTag(101) as! UILabel
        
        if let item = rssItems?[indexPath.item] {
            tittleLabel.text = item.title
            tittleLabel.numberOfLines = 0
            descriptionLabel.numberOfLines = 0
            descriptionLabel.text = "item.description"
        }

  
        return cell
    }
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
