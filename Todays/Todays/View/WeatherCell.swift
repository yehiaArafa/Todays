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
    @IBOutlet weak var date_number: UILabel!
    @IBOutlet weak var date_day: UILabel!
    @IBOutlet weak var weatherCondition: UILabel!
    @IBOutlet weak var weather: UILabel!
    @IBOutlet weak var format: UIImageView!
    @IBOutlet weak var feels: UILabel!
    
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
    
    func setLabels(for searchResult: WeatherCityResult, currentCity: Int, celsius: Bool){
        switch currentCity {
        case 0:
            city.text = "Las Cruces"
        case 1:
            city.text = "El Paso"
        case 2:
            city.text = "Albuquerque"
        default:
            city.text = ""
        }
        weatherCondition.text = searchResult.weatherCondition
        if(celsius){
            weather.text = searchResult.temperature_c
             feels.text = searchResult.feels_c
            format.image = UIImage(named: "celsius")
        }
        else{
            weather.text = searchResult.temperature_f
            feels.text = searchResult.feels_f
            format.image = UIImage(named: "fahrenheit")
        }
      
    }
    
}
