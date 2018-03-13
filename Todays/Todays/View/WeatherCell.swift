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

    override func prepareForReuse() {
        super.prepareForReuse()
        
//        let tableBorderLeft = CGFloat(20)
//        let tableBorderRight = CGFloat(20);
//        let point = CGPoint(x:10,y:10)
//        var mySize = CGSize()
//        mySize.width = 10
//        mySize.height = 10
//        var tableRect = CGRect(origin: point , size: mySize )
//        tableRect.origin.x += tableBorderLeft
//        tableRect.size.width -= tableBorderLeft + tableBorderRight;
//        self.frame = tableRect
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

    
    func setLabel(currentCity:String, currentIcon: String, currentWeather: String){
         city.text = currentCity
         weather.text = currentWeather
    }
    
}
