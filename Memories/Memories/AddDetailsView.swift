//
//  AddDetailsView.swift
//  Memories
//
//  Created by Shangway on 5/20/16.
//  Copyright © 2016 Shangway Hsu. All rights reserved.
//

import UIKit

class AddDetailsView: UIViewController {

    @IBOutlet var memoryTitle: UITextField!
    @IBOutlet var memoryDescription: UITextView!
    
    @IBAction func donePressed(sender: AnyObject) {
        if memoryTitle.text == "" {
            places[places.count - 1]["title"] = places[cellNum]["address"]
        }
        else {
            places[places.count - 1]["title"] = memoryTitle.text
        }
        
        if memoryDescription.text == "" {
            places[places.count - 1]["description"] = "No description available"
        }
        else {
            places[places.count - 1]["description"] = memoryDescription.text
        }
        
        NSUserDefaults.standardUserDefaults().setObject(places, forKey: "places")

        
        self.navigationController!.popToRootViewControllerAnimated(true)

        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
