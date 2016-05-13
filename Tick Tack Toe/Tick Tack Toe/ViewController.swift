//
//  ViewController.swift
//  Tick Tack Toe
//
//  Created by Shangway on 5/12/16.
//  Copyright © 2016 Shangway Hsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var player = 1 //player 1: O's, player 2: X's
    var grid = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var winCombo = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    var isGameOver = false
    
    @IBOutlet var playerTurnLabel: UILabel!
    @IBOutlet var gameOverLabel: UILabel!
    @IBOutlet var button: UIButton!
    @IBOutlet var replay: UIButton!
    
    @IBAction func replayButton(sender: AnyObject) {
        
        //reset to blank game
        player = 1 //player 1: O's, player 2: X's
        grid = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        //remove game over labels
        gameOverLabel.hidden = true
        replay.hidden = true
        UIView.animateWithDuration(0.5) {
            self.gameOverLabel.center = CGPointMake(self.gameOverLabel.center.x - 500, self.gameOverLabel.center.y)
        }
        UIView.animateWithDuration(0.5) {
            self.replay.center = CGPointMake(self.replay.center.x - 500, self.replay.center.y)
        }
        
        //clear the images in grid
        var buttonToClear : UIButton
        for i in 0 ..< 9 {
            buttonToClear = view.viewWithTag(i) as! UIButton
            buttonToClear.setImage(nil, forState: .Normal)
        }
        
        //reset gamestate and turn
        playerTurnLabel.text = "O's Turn"
        isGameOver = false

    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        //only allow move if game is not over
        if !isGameOver {
            
            if grid[sender.tag] == 0 {
                
                grid[sender.tag] = player
                
                if player == 1 {
                    sender.setImage(UIImage(named: "nought.png"), forState: .Normal)
                    player = 2
                    playerTurnLabel.text = "X's Turn"
                    
                } else {
                    sender.setImage(UIImage(named: "cross.png"), forState: .Normal)
                    player = 1
                    playerTurnLabel.text = "O's Turn"
                }
                
                //check is game is over
                let winner = checkGameState()
                if winner == 1 {
                    gameOver()
                    gameOverLabel.text = "O's have won!"
                } else if winner == 2 {
                    gameOver()
                    gameOverLabel.text = "X's have won!"
                } else if winner == 0 {
                    gameOver()
                    gameOverLabel.text = "It is a tie!"
                }
            }
            
        }
        
        
        
    }
    
    /*
     * name: gameOver
     * purpose: reveal the game over labels
     * param: none
     * return: none
     */
    func gameOver() {
        gameOverLabel.hidden = false
        
        UIView.animateWithDuration(0.5) { 
            self.gameOverLabel.center = CGPointMake(self.gameOverLabel.center.x + 500, self.gameOverLabel.center.y)
        }
        replay.hidden = false
        
        UIView.animateWithDuration(0.5) {
            self.replay.center = CGPointMake(self.replay.center.x + 500, self.replay.center.y)
        }
        
        isGameOver = true
        
    }
    
    /*
     * name: checkGameState
     * purpose: checks if a player has won or if there is a tie
     * param: none
     * return: int: the player who won, or 0 if tie or -1 if n/a
     */
    func checkGameState() -> Int{
        
        //check if the horizontals, verticles or diags have all x' or o's
        for combo in winCombo {
            if grid[combo[0]] != 0 && grid[combo[0]] == grid[combo[1]] && grid[combo[1]] == grid[combo[2]] {
                return grid[combo[0]]
            }
        }
        
        //check if there are any more moves possible
        var tie = 0
        for i in grid {
            if i == 0 {
                tie = -1
            }
        }
        return tie
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        //start with player O
        playerTurnLabel.text = "O's Turn"
        
        //hide game over labels
        gameOverLabel.hidden = true
        replay.hidden = true
        gameOverLabel.center = CGPointMake(gameOverLabel.center.x - 500, gameOverLabel.center.y)
        replay.center = CGPointMake(replay.center.x - 500, replay.center.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

