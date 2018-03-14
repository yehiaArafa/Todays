//
//  Loc.swift
//  Todays
//
//  Created by Yehia Arafa on 3/13/18.
//  Copyright © 2018 Yehia Arafa. All rights reserved.
//

import Foundation
import CoreData
import MapKit

class MapLocation: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
    

    
}
