//
//  AddViewController.swift
//  To-do list
//
//  Created by Shangway Hsu on 12/19/15.
//  Copyright © 2015 Shangway Hsu. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

   
    @IBOutlet var titleTextField: UITextField! = UITextField()
    @IBOutlet var notesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func donePressed(sender: AnyObject) {
        let userDefault:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        var itemList:NSMutableArray? = userDefault.objectForKey("itemList") as? NSMutableArray
        
        
        let dataSet:NSMutableDictionary = NSMutableDictionary()
        dataSet.setObject(titleTextField.text!, forKey: "itemTitle")
        dataSet.setObject(notesTextView.text, forKey: "itemNotes")
        
        if (itemList != nil) //already items in list
        {
            let updatedItemList:NSMutableArray = NSMutableArray()
            
            for item:AnyObject in itemList!
            {
                updatedItemList.addObject(item as! NSMutableDictionary)
            }
            
            userDefault.removeObjectForKey("itemList")
            updatedItemList.addObject(dataSet)
            userDefault.setObject(updatedItemList, forKey: "itemList")
            
        }
        else //empty list
        {
            userDefault.removeObjectForKey("itemList")
            itemList = NSMutableArray()
            itemList!.addObject(dataSet)
            userDefault.setObject(itemList, forKey: "itemList")
            
            
        }
        
        userDefault.synchronize()
        
        self.navigationController!.popToRootViewControllerAnimated(true)
        
        
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
