//
//  ViewController.swift
//  Guess My Number
//
//  Created by Shangway on 4/26/16.
//  Copyright © 2016 Shangway Hsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var userGuessTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    @IBAction func guessButton(sender: AnyObject) {
        
        //generate random number
        let rand = String(arc4random_uniform(11))
        
        //check if user guessed correctly or if value is entered
        if rand == userGuessTextField.text {
            
            resultLabel.text = "You guessed it!"
            
        } else if userGuessTextField.text == "" {
            
            resultLabel.text = "Please enter a number"
            
        } else {
            
            resultLabel.text = "Wrong! The number was " + rand
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

