//
//  DetailViewController.swift
//  To-do list
//
//  Created by Shangway Hsu on 12/19/15.
//  Copyright © 2015 Shangway Hsu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var notesTextView: UITextView!
    
    var toDoData:NSMutableDictionary = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.userInteractionEnabled = false
        notesTextView.userInteractionEnabled = false
        
        titleTextField.text = toDoData.objectForKey("itemTitle") as? String
        notesTextView.text = toDoData.objectForKey("itemNotes") as! String
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func trashPressed(sender: AnyObject)
    {
        let userDefault:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        let itemList:NSMutableArray = userDefault.objectForKey("itemList") as! NSMutableArray
        
        let updatedItemList:NSMutableArray = NSMutableArray()
        
        for item:AnyObject in itemList
        {
            updatedItemList.addObject(item as! NSMutableDictionary)
        }
        
        updatedItemList.removeObject(toDoData)
        
        userDefault.setObject(updatedItemList, forKey: "itemList")
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
