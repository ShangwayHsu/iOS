//
//  ViewController.swift
//  Times Table
//
//  Created by Shangway on 5/3/16.
//  Copyright © 2016 Shangway Hsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var sliderValue: UISlider!
    
    //function used to reload data after slider value changes
    @IBAction func sliderChanged(sender: AnyObject) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //first cell is used for current times table base value
        //the rest is just for the times table
        return 21
    }
    
    //function used to create cells times table cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //create init cell
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        //first row is set to be the the title to show current times table base
        if indexPath.row == 0 {
            
            //set so that we only have 20 possible bases
            let currNum = Int(sliderValue.value * 20)
            
            //styling of title cell
            cell.textLabel?.text = "Current Number: "  + String(currNum)
            cell.textLabel?.textAlignment = .Center
            cell.textLabel?.font = UIFont.boldSystemFontOfSize(18.0)
            
            return cell
            
        } else {
            
            let timesTableVal = Int(sliderValue.value * 20)
            
            //eqn text formating.  EX: 5 x 5 = 25
            let equation = String(timesTableVal) + " x " + String(indexPath.row) + " = "
            let product = String(timesTableVal * indexPath.row)
            
            cell.textLabel?.text = equation + product
            
            return cell

        }
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

