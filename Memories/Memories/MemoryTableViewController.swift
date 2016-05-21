//
//  MemoryTableViewController.swift
//  Memories
//
//  Created by Shangway on 5/19/16.
//  Copyright © 2016 Shangway Hsu. All rights reserved.
//

import UIKit
import MapKit

var places = [Dictionary<String,String>()]
var cellNum = -1

class MemoryTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        //save data to NSDefaults
        if NSUserDefaults.standardUserDefaults().objectForKey("places") != nil {
            places = NSUserDefaults.standardUserDefaults().objectForKey("places") as! [Dictionary<String,String>]
        }
        
        //remove the first empty item
        if places.count == 1 && places[0] == Dictionary<String,String>() {
            places.removeAtIndex(0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //return number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    //return number of rows
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }

    //update the text in cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
        
        cell.textLabel?.text = places[indexPath.row]["title"]

        return cell
    }
    
    //swipe to delete element
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //look for swipe to left
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            //remove item
            places.removeAtIndex(indexPath.row)
            
            //update array in NSUserDefaults
            NSUserDefaults.standardUserDefaults().setObject(places, forKey: "places")
            
            self.tableView.reloadData()
        }
    }
    
    
    //bottom two methods for hiding keyboard when "return" key is pressed or pressed out of keyboard
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        cellNum = indexPath.row
        return indexPath
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }

}
