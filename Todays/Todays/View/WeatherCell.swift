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
   
    @IBOutlet weak var icon: UILabel!
    
    @IBOutlet weak var weather: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setLabel(currentCity:String, currentIcon: String, currentWeather: String){
         city.text = currentCity
         weather.text = currentWeather
    }
    
}
