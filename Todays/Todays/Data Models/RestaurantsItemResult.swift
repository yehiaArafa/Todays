//
//  RestaurantsItemResult.swift
//  Todays
//
//  Created by Yehia Arafa on 3/14/18.
//  Copyright © 2018 Yehia Arafa. All rights reserved.
//

import Foundation

func > (lhs: RestuaurantsItemResult, rhs: RestuaurantsItemResult) -> Bool {
    return rhs.rating.isLess(than: lhs.rating)
}

class RestuaurantsItemResultArray:Codable{
    var total:Int = 0
    var businesses = [RestuaurantsItemResult]()
}

class RestuaurantsItemResult:Codable{
    
    var rating = 0.0
    var price = ""
    var phone = ""
    var categories = [RestuaurantsItemResultCategory]()
    var review_count = 0
    var name = ""
    var url = ""
    var image_url = ""
    var location = RestuaurantsItemResultLocation()
  
    var TotalRating:Double{
        return rating
    }
    
    var priceRange:String{
        return price
    }
    
    var phoneNumber:String{
        return phone
    }
    
    var type:String{
        return categories[0].title
    }
    
    var NumberOfReviews:Int{
        return review_count
    }
    
    var restaurantYelpLink:String{
        return url
    }
    
    var imageURL:String{
        return image_url
    }
    
    var address:String{
        return location.address
    }
    
    var restaurantTitle:String{
        return name
    }
    
}


class RestuaurantsItemResultLocation:Codable{
    
    var address1 = ""
    
    var address:String{
        return address1
    }
}

class RestuaurantsItemResultCategory:Codable{
    
    var title = ""
    
    var type:String{
        return title
    }
}
