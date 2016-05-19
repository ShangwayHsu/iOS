//
//  ViewController.swift
//  Location Details
//
//  Created by Shangway on 5/17/16.
//  Copyright © 2016 Shangway Hsu. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager:CLLocationManager!
    
    @IBOutlet var LatitudeLabel: UILabel!
    @IBOutlet var LongitudeLabel: UILabel!
    @IBOutlet var CourseLabel: UILabel!
    @IBOutlet var SpeedLabel: UILabel!
    @IBOutlet var AltitudeLabel: UILabel!
    @IBOutlet var TimeLabel: UILabel!
    @IBOutlet var AddressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager  = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy  = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations[0]
        LatitudeLabel.text = "\(location.coordinate.latitude)"
        LongitudeLabel.text = "\(location.coordinate.longitude)"
        CourseLabel.text = "\(location.course)"
        SpeedLabel.text = "\(location.speed)"
        AltitudeLabel.text = "\(location.altitude)"
        TimeLabel.text = "\(location.timestamp)"
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if error != nil {
                print(error)
                self.AddressLabel.text = "Location not available at this time."
            } else {
                
                if let p = placemarks?[0] {
                    
                    var subThoroughfare:String = ""
                    var thoroughfare:String = ""
                    
                    if (p.subThoroughfare != nil) {
                        
                        subThoroughfare = "\(p.subThoroughfare!)"
                        
                    }
                    if (p.thoroughfare != nil) {
                        thoroughfare = "\(p.thoroughfare!)"
                    }
                    
                    self.AddressLabel.text = "\(subThoroughfare) \(thoroughfare) \n \(p.locality!) \n \(p.postalCode!) \n \(p.country!)"
                    
                }

                
            }
        }
        
    }


}

