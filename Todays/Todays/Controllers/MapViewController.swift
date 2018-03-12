//
//  MapViewController.swift
//  Todays
//
//  Created by Yehia Arafa on 3/11/18.
//  Copyright © 2018 Yehia Arafa. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "LCNewsFeedSegue") {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! RSSFeedViewController
            //controller.delegate = self
            targetController.currentCity = 0
        }
        else if (segue.identifier == "ELPNewsFeedSegue") {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! RSSFeedViewController
            //controller.delegate = self
            targetController.currentCity = 1
        }
        else if (segue.identifier == "ABNewsFeedSegue") {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! RSSFeedViewController
            //controller.delegate = self
            targetController.currentCity = 2
        }
    }

}

