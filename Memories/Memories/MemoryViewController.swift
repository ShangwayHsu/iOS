//
//  MemoryViewController.swift
//  Memories
//
//  Created by Shangway on 5/20/16.
//  Copyright © 2016 Shangway Hsu. All rights reserved.
//

import UIKit
import MapKit
class MemoryViewController: UIViewController, CLLocationManagerDelegate {
    

    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var mapViewController: MKMapView!
    
    //load the data into the title, details and map
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set title and description
        self.title = places[cellNum]["title"]
        descriptionLabel.text = places[cellNum]["description"]
        
        //create current location coordinate
        let longitude = NSString(string: places[cellNum]["long"]!).doubleValue
        let latitude = NSString(string: places[cellNum]["lat"]!).doubleValue
        let coord = CLLocationCoordinate2DMake(latitude, longitude)
        
        //create zoom factor
        let latDelta:CLLocationDegrees = 0.01
        let longDelta:CLLocationDegrees = 0.01
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        //create region
        let region:MKCoordinateRegion = MKCoordinateRegionMake(coord, span)
        
        //set location
        self.mapViewController.setRegion(region, animated: true)
        
        //create pin and label
        let annotation = MKPointAnnotation()
        annotation.coordinate = coord
        annotation.title = self.title
        self.mapViewController.addAnnotation(annotation)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
}
