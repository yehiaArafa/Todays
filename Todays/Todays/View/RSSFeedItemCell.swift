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
    @IBOutlet weak var date: UILabel!
    
    var downloadTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rssImage.layer.cornerRadius = 3
        rssImage.clipsToBounds = true
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
        let trimmed = searchResult.title.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
        titleLabel.text = trimmed
        titleLabel.numberOfLines = 0
        date.text = searchResult.parsedDate
        
        //some networking will be refactored to the Network class
        rssImage.image = UIImage(named: "breakingNews")
        if let imageURL = URL(string: searchResult.imageURL) {
            downloadTask = rssImage.getImage(url: imageURL)
        }
    }
}
