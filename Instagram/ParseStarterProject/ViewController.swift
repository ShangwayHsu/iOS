/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {
    
    var signupActive = true
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    /*
     * creates an alert
     */
    func displayAlert(title: String, message: String) {
        
        if #available(iOS 8.0, *) {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) in
                self.dismissViewControllerAnimated(true, completion: nil)
            })))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        } else {
            print("ios version too old!")
        }
        
    }
    
    //username and password outlets
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var bottomText: UILabel!
    
    //login button
    @IBAction func logIn(sender: AnyObject) {
        
        //if purple button is true we want to make it a login button
        if signupActive {
            
            signupButton.setTitle("Log In", forState: UIControlState.Normal)
            bottomText.text = "Don't have an account? "
            loginButton.setTitle("Sign Up!", forState: UIControlState.Normal)
            signupActive = false
            
        } else {
            
            signupButton.setTitle("Sign Up", forState: UIControlState.Normal)
            bottomText.text = "Already have an account? "
            loginButton.setTitle("Log In!", forState: UIControlState.Normal)
            signupActive = true
            
        }
    }
    
    //signUp button
    @IBAction func signUp(sender: AnyObject) {
        
        if username.text == "" || password.text == "" {
            
            displayAlert("Error in form", message: "Please enter a username and password")
            
        } else {
            
            //get the loading spin wheel.
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            //generic error message
            var errorMessage = "Please try again later"
            
            //if user is currently signing up
            if signupActive {
                
                let user = PFUser()
                user.username = username.text
                user.password = password.text
                
                //saving user to database and stop loading wheel when done
                user.signUpInBackgroundWithBlock({ (success, error) in
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if error == nil {
                        //signup successful
                        
                    } else {
                        
                        if let errorString = error?.userInfo["error"] as? String {
                            errorMessage = errorString
                            
                            //create alert
                            self.displayAlert("SignUp Error", message: errorMessage)
                        }
                    }
                })
                
            } else {
                
                //we are logining in
                PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: { (user, error) in
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()

                    if user != nil {
                        
                        //logged In!
                        self.performSegueWithIdentifier("login", sender: self)

                        
                    } else {
                        
                        //if there is a problem logging in
                        if let errorString = error?.userInfo["error"] as? String {
                            errorMessage = errorString
                            
                            //create alert
                            self.displayAlert("Login Error", message: errorMessage)
                        
                        }
                    }
            
                })
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser()!.username != nil {
            self.performSegueWithIdentifier("login", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
