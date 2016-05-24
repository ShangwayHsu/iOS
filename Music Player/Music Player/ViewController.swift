//
//  ViewController.swift
//  Music Player
//
//  Created by Shangway on 5/24/16.
//  Copyright © 2016 Shangway Hsu. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    var player: AVAudioPlayer = AVAudioPlayer()
    var pauseButton = UIBarButtonItem()
    var playButton = UIBarButtonItem()
    var arrayOfButtons = [UIBarButtonItem]()
    

    @IBOutlet var volume: UISlider!
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet var srub: UISlider!
    @IBOutlet var ffwButton: UIBarButtonItem!
    
    @IBAction func volumeChanged(sender: AnyObject) {
        player.volume = volume.value
    }
    
    //updates scrub value
    @IBAction func skip(sender: AnyObject) {
        player.currentTime = NSTimeInterval(self.srub.value)
    }

    //skip 12 seconds
    @IBAction func ffw(sender: AnyObject) {
        if player.currentTime < player.duration - 12 {
            player.currentTime += 12
            
        }
    }
    
    //go back 12 seconds
    @IBAction func rewind(sender: AnyObject) {
        if player.currentTime > 12 {
            player.currentTime -= 12
            
        }
    }
    
    
    func playButtonTapped() {
        player.play()
        arrayOfButtons = self.toolbar.items!
        arrayOfButtons.removeAtIndex(3)
        arrayOfButtons.insert(pauseButton, atIndex: 3)
        self.toolbar.setItems(arrayOfButtons, animated: false)
    }
    
    func pauseButtonTapped() {
        player.pause()
        arrayOfButtons = self.toolbar.items!
        arrayOfButtons.removeAtIndex(3)
        arrayOfButtons.insert(playButton, atIndex: 3)
        self.toolbar.setItems(arrayOfButtons, animated: false)
    }
    
    func updateScrub() {
        self.srub.value = Float(player.currentTime)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create pause and play button so that they will change when pressed
        pauseButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Pause, target: self, action: #selector(pauseButtonTapped))
        playButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Play, target: self, action: #selector(playButtonTapped))
        
        arrayOfButtons = self.toolbar.items!
        arrayOfButtons.insert(playButton, atIndex: 3)
        self.toolbar.setItems(arrayOfButtons, animated: false)
        
        //get audio file access
        do {
            try self.player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("beethoven", ofType: "mp3")!))

        } catch {
            //error
        }
        
        self.srub.maximumValue = Float(player.duration)
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(updateScrub), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

