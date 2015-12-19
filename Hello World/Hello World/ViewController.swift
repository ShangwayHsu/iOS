//
//  ViewController.swift
//  Hello World
//
//  Created by Shangway Hsu on 11/18/15.
//  Copyright © 2015 Shangway Hsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    @IBAction func helloWorldAction(nameTextField: UITextField) {
        nameLabel.text = "Hello " + (nameTextField.text)!
    }
}

