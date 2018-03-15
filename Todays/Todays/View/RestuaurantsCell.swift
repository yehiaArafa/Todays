//
//  RestuaurantsCell.swift
//  Todays
//
//  Created by Yehia Arafa on 3/14/18.
//  Copyright © 2018 Yehia Arafa. All rights reserved.
//

import UIKit

class RestuaurantsCell: UITableViewCell {

    var downloadTask: URLSessionDownloadTask?
    
    @IBOutlet weak var resturantImage: UIImageView!
    @IBOutlet weak var ratingsImage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var reviews: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        resturantImage.layer.cornerRadius = 3
        resturantImage.clipsToBounds = true
        ratingsImage.layer.cornerRadius = 3
        ratingsImage.clipsToBounds = true
        type.adjustsFontSizeToFitWidth = true
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
    
    func setLabels(for restuaurantsResult: RestuaurantsItemResult){
        self.title.text = restuaurantsResult.restaurantTitle
        self.price.text = restuaurantsResult.priceRange
        self.reviews.text = String(restuaurantsResult.NumberOfReviews)+" reviews"
        self.address.text = restuaurantsResult.address
        self.type.text = restuaurantsResult.type
        self.phone.text = restuaurantsResult.phoneNumber
        resturantImage.image = UIImage(named: "ImagePlaceHolder")
        if let imageURL = URL(string: restuaurantsResult.imageURL) {
            downloadTask = resturantImage.getImage(url: imageURL)
        }
       
        switch(restuaurantsResult.rating){
        case 0.5:
            ratingsImage.image = UIImage(named: "0.5_stars")
        case 1:
            ratingsImage.image = UIImage(named: "1_stars")
        case 1.5:
            ratingsImage.image = UIImage(named: "1.5_stars")
        case 2:
            ratingsImage.image = UIImage(named: "2_stars")
        case 2.5:
            ratingsImage.image = UIImage(named: "2.5_stars")
        case 3:
            ratingsImage.image = UIImage(named: "3_stars")
        case 3.5:
            ratingsImage.image = UIImage(named: "3.5_stars")
        case 4:
            ratingsImage.image = UIImage(named: "4_stars")
        case 4.5:
            ratingsImage.image = UIImage(named: "4.5_stars")
        case 5:
            ratingsImage.image = UIImage(named: "5_stars")
        default:
             ratingsImage.image = UIImage(named: "1_stars")
        }
    }
    

}
