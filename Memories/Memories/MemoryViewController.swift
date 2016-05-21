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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = places[cellNum]["title"]
        descriptionLabel.text = places[cellNum]["description"]
        
        let longitude = NSString(string: places[cellNum]["long"]!).doubleValue
        let latitude = NSString(string: places[cellNum]["lat"]!).doubleValue
        
        let coord = CLLocationCoordinate2DMake(latitude, longitude)
        
        
        let latDelta:CLLocationDegrees = 0.01
        let longDelta:CLLocationDegrees = 0.01
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(coord, span)
        
        self.mapViewController.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coord
        annotation.title = self.title
        self.mapViewController.addAnnotation(annotation)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
