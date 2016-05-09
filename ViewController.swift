//
//  ViewController.swift
//  Tic Tac toe
//
//  Created by Bharatt Kukreja on 2016-02-23.
//  Copyright © 2016 Bharatt Kukreja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 1 = crosses, 2 = noughts
    var activePlayer = 1
    
    var gameActive = true
    
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    var winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    
    @IBOutlet weak var button: UIButton!

    @IBOutlet weak var gameOverLabel: UILabel!
    
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBOutlet weak var button0: UIButton!
    
    
    
    @IBOutlet weak var crossTimer: UILabel!
    
    @IBOutlet weak var noughtTimer: UILabel!
    
    var timer1 = NSTimer()
    var timer2 = NSTimer()
    var timerCross = 0.00
    var timerNought = 0.00
    
    
    @IBAction func playAgainPressed(sender: AnyObject) {
        
        activePlayer = 1
        
        gameActive = true
        
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        
        for var i = 1; i < 9; i++ {
        
            button  = view.viewWithTag(i) as! UIButton
        
            button.setImage(nil, forState: .Normal)
            
        }
        
        button0.setImage(nil, forState: .Normal)
        
        crossTimer.text = "0"
        timerCross = 0
        
        noughtTimer.text = "0"
        timerNought = 0


        gameOverLabel.hidden = true
        playAgainButton.hidden = true
        
        gameOverLabel.center = CGPointMake(gameOverLabel.center.x - 400, gameOverLabel.center.y)
        playAgainButton.center = CGPointMake(playAgainButton.center.x - 400, playAgainButton.center.y)        

        
    }
    /*
    func advanceTimer(timer: NSTimer){
        
        self.time += 0.001;
        
        let milliseconds = self.time * 100;
        let remaingMilliseconds = Int((milliseconds % 1000) / 10);
        let seconds = Int((milliseconds / 1000) % 60)
        
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", remaingMilliseconds)
        
        timerText.text = "\(strSeconds):\(strFraction)";
        
    }
    */
    func increaseTimer1() {
        
        timerCross += 0.1;
        
        let milliseconds = timerCross * 100;
        let remaingMilliseconds = Int((milliseconds % 100) / 10);
        let seconds = Int(milliseconds / 100)
        
        let strSeconds = String(format: "%01d", seconds)
        let strFraction = String(format: "%01d", remaingMilliseconds)

        
        crossTimer.text = "\(strSeconds).\(strFraction)"
    }
    
    func increaseTimer2() {
        
        timerNought += 0.1;
        
        let milliseconds = timerNought * 100;
        let remaingMilliseconds = Int((milliseconds % 100) / 10);
        let seconds = Int(milliseconds / 100)
        
        let strSeconds = String(format: "%01d", seconds)
        let strFraction = String(format: "%01d", remaingMilliseconds)
        
        noughtTimer.text = "\(strSeconds).\(strFraction)"
    }
    
    func play1() {
        
        timer2.invalidate()
        timer1 = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "increaseTimer1", userInfo: nil, repeats: true)
        
        
    }
    
    func play2() {
        
        timer1.invalidate()
        timer2 = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "increaseTimer2", userInfo: nil, repeats: true)
        
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        if gameState[sender.tag] == 0 && gameActive == true {
            
            var image = UIImage()
            
            gameState[sender.tag] = activePlayer
            
            if activePlayer == 1 {
                
                image = UIImage(named: "cross.png")!
                activePlayer = 2
                play2()
                
            }
                
            else {
                
                image = UIImage(named: "nought.png")!
                activePlayer = 1
                play1()
                
            }
            
            sender.setImage(image, forState: .Normal)
            
            for combination in winningCombinations {
                
                if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] &&
                                                     gameState[combination[1]] == gameState[combination[2]] {
                    print("We have a winner")
                                                        
                    if gameState[combination[0]] == 1 {
                        
                        gameOverLabel.text = "Crosses has won"
                    }
                    else {
                        
                        gameOverLabel.text = "Noughts has won"
                        
                    }
                                                        
                    endGame()
                                                        
                    gameActive = false
                }
                
                if gameActive == true {
                    
                    gameActive = false
                    
                    for buttonState in gameState {
                        
                        if buttonState == 0 {
                            
                            gameActive = true
                            
                        }
                        
                    }
                    
                    if gameActive == false {
                        
                        if(timerCross < timerNought) {
                            gameOverLabel.text = "Crosses win by time"
                        }
                        else if(timerNought < timerCross) {
                            gameOverLabel.text = "Noughts win by time"
                        }
                        else {
                            gameOverLabel.text = "It's a draw"
                        }
                        endGame()
                    }
                    
                }
                
            }
            
            
        }
        
            
    }
    
    
    func endGame() {
        
        timer1.invalidate()
        timer2.invalidate()
        
        gameOverLabel.hidden = false
        playAgainButton.hidden = false
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            self.gameOverLabel.center = CGPointMake(self.gameOverLabel.center.x + 500, self.gameOverLabel.center.y)
            
            self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x + 500, self.playAgainButton.center.y)
            
        })
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        gameOverLabel.hidden = true
        playAgainButton.hidden = true
        
        gameOverLabel.center = CGPointMake(gameOverLabel.center.x - 400, gameOverLabel.center.y)
        playAgainButton.center = CGPointMake(playAgainButton.center.x - 400, playAgainButton.center.y)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    


}

