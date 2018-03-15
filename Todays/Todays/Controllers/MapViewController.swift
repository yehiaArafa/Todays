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
    var annotations: [MapLocation] = []
    
    
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
        
        var annotation = MapLocation(title: ElPasoMapAnnotations.title,
                                 locationName: ElPasoMapAnnotations.locationName,
                                 discipline: ElPasoMapAnnotations.discipline,
                                 coordinate: CLLocationCoordinate2D(latitude: ElPasoMapAnnotations.latitude, longitude: ElPasoMapAnnotations.longitude))
        annotations.append(annotation)
        
        annotation = MapLocation(title: LasCrucesMapAnnotations.title,
                        locationName: LasCrucesMapAnnotations.locationName,
                        discipline: LasCrucesMapAnnotations.discipline,
                        coordinate: CLLocationCoordinate2D(latitude: LasCrucesMapAnnotations.latitude, longitude: LasCrucesMapAnnotations.longitude))
        annotations.append(annotation)
        
        annotation = MapLocation(title: AlbuquerqueMapAnnotations.title,
                                 locationName: AlbuquerqueMapAnnotations.locationName,
                                 discipline: AlbuquerqueMapAnnotations.discipline,
                                 coordinate: CLLocationCoordinate2D(latitude: AlbuquerqueMapAnnotations.latitude, longitude: AlbuquerqueMapAnnotations.longitude))
        annotations.append(annotation)

        mapView.addAnnotations(annotations)
    }
    
    @objc func showLocationDetails(_ sender: UIButton) {
        if(sender.tag == 0 ){
            performSegue(withIdentifier: "ELPNewsFeedSegue" , sender: MapViewController.self)
        }
        else if(sender.tag == 1){
            performSegue(withIdentifier: "LCNewsFeedSegue", sender: MapViewController.self)
        }
        else if(sender.tag == 2 ){
            performSegue(withIdentifier: "ABNewsFeedSegue", sender: MapViewController.self)
        }
      
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is MapLocation else {
            return nil
        }
        let identifier = "MapLocation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            pinView.isEnabled = true
            pinView.canShowCallout = true
            pinView.animatesDrop = false
            pinView.pinTintColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            
            
            let rightButton = UIButton(type: .detailDisclosure)
            rightButton.addTarget(self, action: #selector(showLocationDetails), for: .touchUpInside)
            pinView.rightCalloutAccessoryView = rightButton
            
            annotationView = pinView
        }
        
        if let annotationView = annotationView {
            annotationView.annotation = annotation
            
            let button = annotationView.rightCalloutAccessoryView
                as! UIButton
            if let index = annotations.index(of: annotation as! MapLocation) {
                button.tag = index
            }
        }
        
        return annotationView
    }

    
}



