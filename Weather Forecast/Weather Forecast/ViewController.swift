//
//  ViewController.swift
//  Weather Forecast
//
//  Created by Shangway on 5/10/16.
//  Copyright © 2016 Shangway Hsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   

    
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var cityTextField: UITextField!
    
    @IBAction func forecastButton(sender: AnyObject) {
        
        var failed = true
        
        let attemptUrl = NSURL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        //check if url is able to be made
        if let url = attemptUrl {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                
                //check if there is data
                if let urlContent = data {
                    
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    
                    //locate where the forcast is
                    var webArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                    
                    if webArray.count > 1 {
                        
                        //parsing data
                        webArray = webArray[1].componentsSeparatedByString("</span>")
                        
                        if webArray.count > 1 {
                            
                            failed = false
                            
                            var forecast = webArray[0]
                            
                            //fix the degree sign from html
                            forecast = forecast.stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                            
                            
                            dispatch_async(dispatch_get_main_queue(), {
                                
                                //background image change
                                if forecast.containsString("rain") {
                                    print("raining image pls")
                                    self.weatherImage.image = UIImage(named: "raining.jpg")
                                } else if forecast.containsString("sunny") {
                                    self.weatherImage.image = UIImage(named: "sunnyView.jpg")
                                } else {
                                    self.weatherImage.image = UIImage(named: "defaultWeather.jpg")
                                }
                                self.forecastResult.text = forecast
                            })

                        }
                        
                    }
                }
            }
            task.resume()
            
            if failed {
                self.forecastResult.text = cityTextField.text! + " Is An Invalid City - please try again"

            }

        } else {
            forecastResult.text = cityTextField.text! + " Is An Invalid City - please try again"
        }
        
        
    }
    @IBOutlet var forecastResult: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

}

