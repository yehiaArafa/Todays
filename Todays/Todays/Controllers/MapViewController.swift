//
//  MapViewController.swift
//  Todays
//
//  Created by Yehia Arafa on 3/11/18.
//  Copyright © 2018 Yehia Arafa. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zoomMap()
        updatePins()
    }
    
    
    func zoomMap(){
        let myLocation = CLLocationCoordinate2D(latitude: 33.9178438, longitude: -106.8658586)
        let region = MKCoordinateRegionMakeWithDistance(myLocation, 270000, 290000)
        mapView.setRegion(mapView.regionThatFits(region),animated: (true))
    }
    
    func updatePins(){
        
        var annotations: [MapLocation] = []
        
        var annotation = MapLocation(title: LasCrucesMapAnnotations.title,
                        locationName: LasCrucesMapAnnotations.locationName,
                        discipline: LasCrucesMapAnnotations.discipline,
                        coordinate: CLLocationCoordinate2D(latitude: LasCrucesMapAnnotations.latitude, longitude: LasCrucesMapAnnotations.longitude))
        annotations.append(annotation)
        
        annotation = MapLocation(title: ElPasoMapAnnotations.title,
                                 locationName: ElPasoMapAnnotations.locationName,
                                 discipline: ElPasoMapAnnotations.discipline,
                                 coordinate: CLLocationCoordinate2D(latitude: ElPasoMapAnnotations.latitude, longitude: ElPasoMapAnnotations.longitude))
        annotations.append(annotation)
        
        annotation = MapLocation(title: AlbuquerqueMapAnnotations.title,
                                 locationName: AlbuquerqueMapAnnotations.locationName,
                                 discipline: AlbuquerqueMapAnnotations.discipline,
                                 coordinate: CLLocationCoordinate2D(latitude: AlbuquerqueMapAnnotations.latitude, longitude: AlbuquerqueMapAnnotations.longitude))
        annotations.append(annotation)

        mapView.addAnnotations(annotations)
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "LCNewsFeedSegue") {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! RSSFeedViewController
            targetController.currentCity = 0
        }
        else if (segue.identifier == "ELPNewsFeedSegue") {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! RSSFeedViewController
            targetController.currentCity = 1
        }
        else if (segue.identifier == "ABNewsFeedSegue") {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! RSSFeedViewController
            targetController.currentCity = 2
        }
    }

}

extension MapViewController: MKMapViewDelegate {
    
  
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if((view.annotation?.title)! == "Las Cruces"){
            performSegue(withIdentifier: "LCNewsFeedSegue", sender: MapViewController.self)
        }
        else if((view.annotation?.title)! == "El Paso"){
            performSegue(withIdentifier: "ELPNewsFeedSegue", sender: MapViewController.self)
        }
        else if((view.annotation?.title)! == "Albuquerque"){
            performSegue(withIdentifier: "ABNewsFeedSegue", sender: MapViewController.self)
        }
    }
    
    

}



