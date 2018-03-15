//
//  WeatherCell.swift
//  Todays
//
//  Created by Yehia Arafa on 3/12/18.
//  Copyright © 2018 Yehia Arafa. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var weather: UILabel!
    
    var downloadTask: URLSessionDownloadTask?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            var frame = newValue
            frame.origin.x += 25
            frame.size.width -= 2 * 25
            super.frame = frame
        }
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
    
    func setLabel(currentCity:String, currentIconLink: String, currentWeather: String){
         city.text = currentCity
         weather.text = currentWeather
        
        iconImage.image = UIImage(named: "ImagePlaceHolder")
     
        if let imageURL = URL(string: currentIconLink) {
            downloadTask = iconImage.getImage(url: imageURL)
        }
        
    }
    
}
