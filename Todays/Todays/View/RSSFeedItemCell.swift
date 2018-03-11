//
//  RssFeedItemCell.swift
//  Todays
//
//  Created by Yehia Arafa on 3/9/18.
//  Copyright © 2018 Yehia Arafa. All rights reserved.
//

import UIKit

class RSSFeedItemCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rssImage: UIImageView!
    var downloadTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        downloadTask?.cancel()
        downloadTask = nil
    }
    
    func setLabels(for searchResult: RSSFeedItemResult){
         titleLabel.text = searchResult.title
         titleLabel.numberOfLines = 0
        
        //some networking will be refactored to the Network class
        rssImage.image = UIImage(named: "breakingNews")
        if let imageURL = URL(string: searchResult.imageURL) {
            downloadTask = rssImage.getImage(url: imageURL)
        }
        
        
        
    }
}
