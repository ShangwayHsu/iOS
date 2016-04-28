//
//  ViewController.swift
//  Timer
//
//  Created by Shangway on 4/28/16.
//  Copyright © 2016 Shangway Hsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //time and timer variables
    var time = 0.00
    var timer = NSTimer()
    
    @IBOutlet var timerLabel: UILabel!
    
    @IBAction func startButton(sender: AnyObject) {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("incrementTimer"), userInfo: nil, repeats: true)

    }
    
    @IBAction func stopButton(sender: AnyObject) {
        timer.invalidate()
    }
    
    @IBAction func resetButton(sender: AnyObject) {
        timer.invalidate()
        time = 0.00
        timerLabel.text = "0.00"
    }
 
    

    
    func incrementTimer() {
        
        time += 0.01
        timerLabel.text = "\(time)"
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //interval of 1 second and used on curr view controller and runs the function result every second
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

