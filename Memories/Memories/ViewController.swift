//
//  ViewController.swift
//  Memories
//
//  Created by Shangway on 5/19/16.
//  Copyright © 2016 Shangway Hsu. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager: CLLocationManager!
    
    @IBOutlet var mapViewController: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        let userLongPress = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.dropPin(_:)))
        userLongPress.minimumPressDuration = 1.5
        mapViewController.addGestureRecognizer(userLongPress)
    }
    
    func dropPin(gestureRecognizer:UIGestureRecognizer) {
        //only first indication of long touch because we only want one pin to drop
        mapViewController.removeAnnotations(mapViewController.annotations)
        
        //get touch point
        let touchPoint = gestureRecognizer.locationInView(self.mapViewController)
        let pinCoord = mapViewController.convertPoint(touchPoint, toCoordinateFromView: self.mapViewController)
        let locationCoord = CLLocation(latitude: pinCoord.latitude,longitude: pinCoord.longitude)
            
        //get address
        var address = ""
        CLGeocoder().reverseGeocodeLocation(locationCoord, completionHandler: { (placemarks, error) in
            if error == nil {
                
                if let p = placemarks?[0] {
                    var subThoroughfare:String = ""
                    var thoroughfare:String = ""
                    
                    //check if there is a valide subthoroughfare and thoroughfare
                    if p.subThoroughfare != nil {
                        subThoroughfare = p.subThoroughfare!
                    }
                    if p.thoroughfare != nil {
                        thoroughfare = p.thoroughfare!
                    }
                    
                    address = "\(subThoroughfare) \(thoroughfare)"
                    
                }
                    
            }
            
            //in case there is no address just add date to address
            if address == " " {
                let format = NSDateFormatter()
                format.dateFormat = "MM-dd-yyy HH:mm"
                address = "Added \(format.stringFromDate(NSDate()))."
            }
            
            //update annotation
            let annotation = MKPointAnnotation()
            annotation.coordinate = pinCoord
            annotation.title = "\(address)"
            self.mapViewController.addAnnotation(annotation)

        })
            
            
    }
    


    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currLocation:CLLocation = locations[0]
        
        let lat = currLocation.coordinate.latitude
        let long = currLocation.coordinate.longitude
        let coord = CLLocationCoordinate2DMake(lat, long)
        
        
        let latDelta:CLLocationDegrees = 0.01
        let longDelta:CLLocationDegrees = 0.01
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(coord, span)
        
        self.mapViewController.setRegion(region, animated: true)
        mapViewController.showsUserLocation = true
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

