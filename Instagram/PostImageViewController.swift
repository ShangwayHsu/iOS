//
//  PostImageViewController.swift
//  Instagram
//
//  Created by Shangway on 7/5/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
class PostImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //create activity indicator
    var activityIndicator = UIActivityIndicatorView()
    var imageDidSet = false
    
    @IBOutlet var imageToPost: UIImageView!
    
    @IBAction func chooseImage(sender: AnyObject) {
        
        let image = UIImagePickerController()
        image.delegate = self
        
        //pull up photo lib
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        //show photo selector
        self.presentViewController(image, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        //once image is picked then dismiss gallery view controller
        self.dismissViewControllerAnimated(true, completion:nil)
        
        imageToPost.image = image
        
        //image set
        imageDidSet = true
    }
    
    @IBOutlet var caption: UITextField!
    
    @IBAction func post(sender: AnyObject) {
        
        //error message if no image was set
        if imageDidSet == false {
            displayAlert("Image Required!", message: "Please select an image.")
            return
        }
        
        //set up the loading wheel
        activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
        activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        //block interaction
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        //create new data object called "Post"
        let post = PFObject(className: "Post")
        post["caption"] = caption.text
        post["userId"] = PFUser.currentUser()?.objectId
        
        //convert image into a file
        let imageData = UIImageJPEGRepresentation(imageToPost.image!, 0.1)
        let imageFile = PFFile(name: "image.png", data: imageData!)
        post["imageFile"] = imageFile
        
        //saving image
        post.saveInBackgroundWithBlock { (success, error) in
            
            self.activityIndicator.stopAnimating()
            
            //block interaction
            UIApplication.sharedApplication().endIgnoringInteractionEvents()

            if error == nil {
                
                //reset images
                self.displayAlert("Image Posted!", message: "Your image has been posted successfully!")
                self.imageToPost.image = UIImage(named: "placeholder-image.png")
                self.caption.text = ""
                self.dismissViewControllerAnimated(true, completion: nil)

            } else {
                self.displayAlert("Could not post image", message: "Please try again later")

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     * creates an alert
     */
    func displayAlert(title: String, message: String) {
        
        if #available(iOS 8.0, *) {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) in
            })))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        } else {
            print("ios version too old!")
        }
        
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
