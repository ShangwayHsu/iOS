//
//  MasterTableViewController.swift
//  To-do list
//
//  Created by Shangway Hsu on 12/19/15.
//  Copyright © 2015 Shangway Hsu. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController {
    
    
    
    var toDoItems:NSMutableArray = NSMutableArray()
    
  
    
    override init(style: UITableViewStyle)
    {
        super.init(style: style)
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        let userDefault:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        let itemList:NSMutableArray? = userDefault.objectForKey("itemList") as? NSMutableArray
        if (itemList != nil)
        {
            toDoItems = itemList!
        }
        
        self.tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDoItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let todoItem:NSMutableDictionary = toDoItems.objectAtIndex(indexPath.row) as! NSMutableDictionary
        cell.textLabel!.text = todoItem.objectForKey("itemTitle") as? String


        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "detailView")
        {
            let selectedIndexPath:NSIndexPath = self.tableView.indexPathForSelectedRow!
            let detailViewContoller:DetailViewController = segue.destinationViewController as! DetailViewController
            
            detailViewContoller.toDoData = toDoItems.objectAtIndex(selectedIndexPath.row) as! NSMutableDictionary
        }
    }
    

}
