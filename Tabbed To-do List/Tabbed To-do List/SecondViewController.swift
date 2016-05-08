//
//  SecondViewController.swift
//  Tabbed To-do List
//
//  Created by Shangway on 5/7/16.
//  Copyright © 2016 Shangway Hsu. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var itemText: UITextField!

    @IBAction func addItem(sender: AnyObject) {
        toDoList.append(itemText.text!)
        
        //reset the text field
        itemText.text = ""
        
        NSUserDefaults.standardUserDefaults().setObject(toDoList, forKey: "toDoList")
    }
    
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

