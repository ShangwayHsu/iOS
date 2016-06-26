//
//  TableViewController.swift
//  Instagram
//
//  Created by Shangway on 6/25/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
class TableViewController: UITableViewController {
    var usernames = [""]
    var userids = [""]
    var isFollowing = ["":false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Users"
        let query = PFUser.query()
        
        //query to retrieve all users
        query?.findObjectsInBackgroundWithBlock({ (objects, error) in
            if let users = objects {
                
                //clear previous array
                self.usernames.removeAll(keepCapacity: true)
                self.userids.removeAll(keepCapacity: true)
                self.isFollowing.removeAll(keepCapacity: true)
                
                for object in users {
                    if let user = object as? PFUser {
                        
                        if user.objectId != PFUser.currentUser()?.objectId {
                            
                            //add users
                            self.usernames.append(user.username!)
                            self.userids.append(user.objectId!)
                            
                            //check following details
                            let queryFollowers = PFQuery(className: "followers")
                            queryFollowers.whereKey("follower", equalTo: (PFUser.currentUser()?.objectId)!)
                            queryFollowers.whereKey("following", equalTo: user.objectId!)
                            
                            queryFollowers.findObjectsInBackgroundWithBlock({ (objects, error) in
                                
                                if let objects = objects {
                                    
                                    //check if that query actually exists
                                    if objects.count > 0 {
                                        self.isFollowing[user.objectId!] = true
                                    } else {
                                        self.isFollowing[user.objectId!] = false
                                    }
                                } 
                                
                                //checks when isFollowing is completely updated
                                if self.isFollowing.count == self.userids.count {
                                    self.tableView.reloadData()
                                    print(self.isFollowing)


                                }

                                
                            })
                        }

                    }
                }
            }

            
        })
        
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
        // #warning Incomplete implementation, return the number of rows
        return usernames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        cell.textLabel!.text = usernames[indexPath.row]
        
        //add checkmark if user is following this curr user
        if isFollowing[userids[indexPath.row]] == true {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        //follow or unfollow a user
        if isFollowing[userids[indexPath.row]] == false {
            
            //now following so add checkmark
            isFollowing[userids[indexPath.row]] = true
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            //create new entry in database
            let following = PFObject(className: "followers")
            following["following"] = userids[indexPath.row]
            following["follower"] = PFUser.currentUser()?.objectId
            
            following.saveInBackground()

        } else {
            //unfollow so no more checkmark
            isFollowing[userids[indexPath.row]] = false
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            //find query in database
            let query = PFQuery(className: "followers")
            query.whereKey("follower", equalTo: (PFUser.currentUser()?.objectId)!)
            query.whereKey("following", equalTo: userids[indexPath.row])
            
            query.findObjectsInBackgroundWithBlock({ (allObjects, error) in
                
                //delete all instances of that following
                if let objects = allObjects {
                    for object in objects {

                        object.deleteInBackground()
                    }
                }
                
            })
 


        }
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
