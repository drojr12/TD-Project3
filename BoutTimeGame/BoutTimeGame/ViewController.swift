//
//  ViewController.swift
//  BoutTimeGame
//
//  Created by David Oliveira on 6/23/18.
//  Copyright © 2018 David Oliveira. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController {

    @IBOutlet weak var factLabel1: UILabel!
    @IBOutlet weak var factLabel2: UILabel!
    @IBOutlet weak var factLabel3: UILabel!
    @IBOutlet weak var factLabel4: UILabel!
    @IBOutlet weak var shakeToCompleteLabel: UILabel!
    
    
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var firstUpButton: UIButton!
    @IBOutlet weak var firstDownButton: UIButton!
    @IBOutlet weak var secondUpButton: UIButton!
    @IBOutlet weak var secondDownButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var nextRoundSuccessButton: UIButton!
    @IBOutlet weak var nextRoundFailButton: UIButton!
    @IBOutlet weak var showScoreButton: UIButton!
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
    override var canBecomeFirstResponder: Bool {
        get { return true }
    }
    
    var countdownTimer: Timer!
    var totalTime = 60
    let gameManager = GameManager()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scoreController = segue.destination as? ScoreController {
            scoreController.totalRoundsText = String(gameManager.totalRounds)
            scoreController.scoreText = String(gameManager.totalScore)
            scoreController.viewController = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.becomeFirstResponder()
        
        //Set the images for the highlighted buttons (when they are pressed)
        gameManager.setImagesForHighlightedButtons(downButton: downButton, firstUpButton: firstUpButton, firstDownButton: firstDownButton, secondUpButton: secondUpButton, secondDownButton: secondDownButton, upButton: upButton)
        
        // Set the label edges to be round
        gameManager.setLabelRoundedEdges(for: factLabel1, factLabel2: factLabel2, factLabel3: factLabel3, factLabel4: factLabel4)
        
        //Make the  buttons the most top layer over the labels
        gameManager.setButtonsAsTopLayer(withView: view, for: downButton, firstUpButton: firstUpButton, firstDownButton: firstDownButton, secondUpButton: secondUpButton, secondDownButton: secondDownButton, upButton: upButton)
        
        //Hide the UI Components
        shakeToCompleteLabel.isHidden = true
        nextRoundSuccessButton.isHidden = true
        nextRoundFailButton.isHidden = true
        showScoreButton.isHidden = true
        
        //Load Sounds
        gameManager.loadCorrectDingSound()
        gameManager.loadIncorrectBuzzSound()
        gameManager.loadButtonPressSound()
        
        displayRound(factLabel1: factLabel1, factLabel2: factLabel2, factLabel3: factLabel3, factLabel4: factLabel4)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This is the function that gets fired when the phone detects a shake
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            
            //End the timer
            endTimer()
            
            // Check if there are facts in the label's.text property and then append them to the currentOrderOfFacts array
            if let fact1 = factLabel1.text, let fact2 = factLabel2.text, let fact3 = factLabel3.text, let fact4 = factLabel4.text {
                gameManager.theGame.currentOrderOfFacts.append(Fact(fact: fact1))
                gameManager.theGame.currentOrderOfFacts.append(Fact(fact: fact2))
                gameManager.theGame.currentOrderOfFacts.append(Fact(fact: fact3))
                gameManager.theGame.currentOrderOfFacts.append(Fact(fact: fact4))
            }
            
            // Once the array is populated, call the checkFactOrder method
            checkFactOrder()
            
            //After fact order is checked, remove all elements from the currentOrderOfFacts array
            // to prepare for next call to checkFactOrder function
            gameManager.theGame.currentOrderOfFacts.removeAll()
            
        }
    }
    
    //Plays a sound when any arrow button is pressed and moves the labels accordingly
    @IBAction func changeLabelOrder(_ sender: UIButton) {
        if (sender === downButton) {
            gameManager.playButtonPressSound()
            let container = factLabel2.text
            factLabel2.text = factLabel1.text
            factLabel1.text = container
        } else if (sender === firstUpButton) {
            gameManager.playButtonPressSound()
            let container = factLabel1.text
            factLabel1.text = factLabel2.text
            factLabel2.text = container
        } else if (sender === firstDownButton) {
            gameManager.playButtonPressSound()
            let container = factLabel3.text
            factLabel3.text = factLabel2.text
            factLabel2.text = container
        } else if (sender === secondUpButton) {
            gameManager.playButtonPressSound()
            let container = factLabel2.text
            factLabel2.text = factLabel3.text
            factLabel3.text = container
        } else if (sender === secondDownButton) {
            gameManager.playButtonPressSound()
            let container = factLabel4.text
            factLabel4.text = factLabel3.text
            factLabel3.text = container
        } else if (sender === upButton) {
            gameManager.playButtonPressSound()
            let container = factLabel3.text
            factLabel3.text = factLabel4.text
            factLabel4.text = container
        }
    }
    
    //Action for displayNextRound button
    @IBAction func displayNextRound() {
        displayRound(factLabel1: factLabel1, factLabel2: factLabel2, factLabel3: factLabel3, factLabel4: factLabel4)
    }
    
    // function for handler for the UIAlertAction instance above
    // just displays the 1st round when dismissing the alert
    func dismissAlert(sender: UIAlertAction) -> Void {
        displayRound(factLabel1: factLabel1, factLabel2: factLabel2, factLabel3: factLabel3, factLabel4: factLabel4)
    }
    
    func resetGame() {
        // Reset current round, totalScore, and totalTime
        gameManager.currentRound = 1
        gameManager.totalScore = 0
        totalTime = 60
        
        // Show the timerLabel, and reset the text that is currently in the timerLabel.text
        shakeToCompleteLabel.isHidden = false
        timerLabel.isHidden = false
        timerLabel.text = ""
        
        // Hide the showScoreButton
        showScoreButton.isHidden = true
        
        // After resetting above variables/properties - Display Round
        displayRound(factLabel1: factLabel1, factLabel2: factLabel2, factLabel3: factLabel3, factLabel4: factLabel4)
    }
    
    
    
    func checkFactOrder() {
        //Check each setOfFacts to the currentOrderOfFacts to see if they have the correct order or not.
        if  gameManager.theGame.setOfFacts1[0].fact == gameManager.theGame.currentOrderOfFacts[0].fact &&
            gameManager.theGame.setOfFacts1[1].fact == gameManager.theGame.currentOrderOfFacts[1].fact &&
            gameManager.theGame.setOfFacts1[2].fact == gameManager.theGame.currentOrderOfFacts[2].fact &&
            gameManager.theGame.setOfFacts1[3].fact == gameManager.theGame.currentOrderOfFacts[3].fact {
            
            // Implement logic for when the player wins, because the facts are in the correct order.
            //Play correct ding
            gameManager.playCorrectDingSound()
            
            //Increase totalScore count
            gameManager.totalScore += 1
            
            //Hide proper labels
            shakeToCompleteLabel.isHidden = true
            timerLabel.isHidden = true
            
            //Show the success button
            nextRoundSuccessButton.isHidden = false
            
            //Make buttons not interactable
            toggleEnableButtonInteractionTo(false)
        } else if
            gameManager.theGame.setOfFacts2[0].fact == gameManager.theGame.currentOrderOfFacts[0].fact &&
            gameManager.theGame.setOfFacts2[1].fact == gameManager.theGame.currentOrderOfFacts[1].fact &&
            gameManager.theGame.setOfFacts2[2].fact == gameManager.theGame.currentOrderOfFacts[2].fact &&
            gameManager.theGame.setOfFacts2[3].fact == gameManager.theGame.currentOrderOfFacts[3].fact {
            
            gameManager.playCorrectDingSound()
            
            gameManager.totalScore += 1
            
            shakeToCompleteLabel.isHidden = true
            timerLabel.isHidden = true
            
            nextRoundSuccessButton.isHidden = false
            
            toggleEnableButtonInteractionTo(false)
        } else if
            gameManager.theGame.setOfFacts3[0].fact == gameManager.theGame.currentOrderOfFacts[0].fact &&
            gameManager.theGame.setOfFacts3[1].fact == gameManager.theGame.currentOrderOfFacts[1].fact &&
            gameManager.theGame.setOfFacts3[2].fact == gameManager.theGame.currentOrderOfFacts[2].fact &&
            gameManager.theGame.setOfFacts3[3].fact == gameManager.theGame.currentOrderOfFacts[3].fact {
            
            gameManager.playCorrectDingSound()
            
            gameManager.totalScore += 1
            
            shakeToCompleteLabel.isHidden = true
            timerLabel.isHidden = true
            
            nextRoundSuccessButton.isHidden = false
            
            toggleEnableButtonInteractionTo(false)
        } else if
            gameManager.theGame.setOfFacts4[0].fact == gameManager.theGame.currentOrderOfFacts[0].fact &&
            gameManager.theGame.setOfFacts4[1].fact == gameManager.theGame.currentOrderOfFacts[1].fact &&
            gameManager.theGame.setOfFacts4[2].fact == gameManager.theGame.currentOrderOfFacts[2].fact &&
            gameManager.theGame.setOfFacts4[3].fact == gameManager.theGame.currentOrderOfFacts[3].fact {
            
            gameManager.playCorrectDingSound()
            
            gameManager.totalScore += 1
            
            shakeToCompleteLabel.isHidden = true
            timerLabel.isHidden = true
            
            nextRoundSuccessButton.isHidden = false
            
            toggleEnableButtonInteractionTo(false)
            
        } else if
            gameManager.theGame.setOfFacts5[0].fact == gameManager.theGame.currentOrderOfFacts[0].fact &&
            gameManager.theGame.setOfFacts5[1].fact == gameManager.theGame.currentOrderOfFacts[1].fact &&
            gameManager.theGame.setOfFacts5[2].fact == gameManager.theGame.currentOrderOfFacts[2].fact &&
            gameManager.theGame.setOfFacts5[3].fact == gameManager.theGame.currentOrderOfFacts[3].fact {
            
            gameManager.playCorrectDingSound()
            
            gameManager.totalScore += 1
            
            shakeToCompleteLabel.isHidden = true
            timerLabel.isHidden = true
            
            nextRoundSuccessButton.isHidden = false
            
            toggleEnableButtonInteractionTo(false)
            
        } else if
            gameManager.theGame.setOfFacts6[0].fact == gameManager.theGame.currentOrderOfFacts[0].fact &&
            gameManager.theGame.setOfFacts6[1].fact == gameManager.theGame.currentOrderOfFacts[1].fact &&
            gameManager.theGame.setOfFacts6[2].fact == gameManager.theGame.currentOrderOfFacts[2].fact &&
            gameManager.theGame.setOfFacts6[3].fact == gameManager.theGame.currentOrderOfFacts[3].fact {
            
            gameManager.playCorrectDingSound()
            
            gameManager.totalScore += 1
            
            shakeToCompleteLabel.isHidden = true
            timerLabel.isHidden = true
            
            nextRoundSuccessButton.isHidden = false
            
            toggleEnableButtonInteractionTo(false)
            
        } else if
            gameManager.theGame.setOfFacts7[0].fact == gameManager.theGame.currentOrderOfFacts[0].fact &&
            gameManager.theGame.setOfFacts7[1].fact == gameManager.theGame.currentOrderOfFacts[1].fact &&
            gameManager.theGame.setOfFacts7[2].fact == gameManager.theGame.currentOrderOfFacts[2].fact &&
            gameManager.theGame.setOfFacts7[3].fact == gameManager.theGame.currentOrderOfFacts[3].fact {
            
            gameManager.playCorrectDingSound()
            
            gameManager.totalScore += 1
            
            shakeToCompleteLabel.isHidden = true
            timerLabel.isHidden = true
            
            nextRoundSuccessButton.isHidden = false
            
            toggleEnableButtonInteractionTo(false)
            
        } else if
            gameManager.theGame.setOfFacts8[0].fact == gameManager.theGame.currentOrderOfFacts[0].fact &&
            gameManager.theGame.setOfFacts8[1].fact == gameManager.theGame.currentOrderOfFacts[1].fact &&
            gameManager.theGame.setOfFacts8[2].fact == gameManager.theGame.currentOrderOfFacts[2].fact &&
            gameManager.theGame.setOfFacts8[3].fact == gameManager.theGame.currentOrderOfFacts[3].fact {
            
            gameManager.playCorrectDingSound()
            
            gameManager.totalScore += 1
            
            shakeToCompleteLabel.isHidden = true
            timerLabel.isHidden = true
            
            nextRoundSuccessButton.isHidden = false
            
            toggleEnableButtonInteractionTo(false)
            
        } else if
            gameManager.theGame.setOfFacts9[0].fact == gameManager.theGame.currentOrderOfFacts[0].fact &&
            gameManager.theGame.setOfFacts9[1].fact == gameManager.theGame.currentOrderOfFacts[1].fact &&
            gameManager.theGame.setOfFacts9[2].fact == gameManager.theGame.currentOrderOfFacts[2].fact &&
            gameManager.theGame.setOfFacts9[3].fact == gameManager.theGame.currentOrderOfFacts[3].fact {
            
            gameManager.playCorrectDingSound()
            
            gameManager.totalScore += 1
            
            shakeToCompleteLabel.isHidden = true
            timerLabel.isHidden = true
            
            nextRoundSuccessButton.isHidden = false
            
            toggleEnableButtonInteractionTo(false)
            
        } else if
            gameManager.theGame.setOfFacts10[0].fact == gameManager.theGame.currentOrderOfFacts[0].fact &&
            gameManager.theGame.setOfFacts10[1].fact == gameManager.theGame.currentOrderOfFacts[1].fact &&
            gameManager.theGame.setOfFacts10[2].fact == gameManager.theGame.currentOrderOfFacts[2].fact &&
            gameManager.theGame.setOfFacts10[3].fact == gameManager.theGame.currentOrderOfFacts[3].fact {
            
            gameManager.playCorrectDingSound()
            
            gameManager.totalScore += 1
            
            shakeToCompleteLabel.isHidden = true
            timerLabel.isHidden = true
            
            nextRoundSuccessButton.isHidden = false
            
            toggleEnableButtonInteractionTo(false)
            
        } else {
            //Implement Logic for when the player loses, because the facts aren't in the correct order
            print("You don't have the correct order. You have lost this round!")
            
            // Play incorrect buzz sound
            gameManager.playIncorrectBuzzSound()
            
            //Hide the shake to complete label & timerlabel
            shakeToCompleteLabel.isHidden = true
            timerLabel.isHidden = true
            
            //Show the fail button and turn off buttons
            nextRoundFailButton.isHidden = false
            toggleEnableButtonInteractionTo(false)
        }
    }//End of CheckFactOrder
    
    func displayRound(factLabel1: UILabel, factLabel2: UILabel, factLabel3: UILabel, factLabel4: UILabel) {
        //Set the buttons to toggle true for property isUserInteractionEnabled when a round is displayed
        toggleEnableButtonInteractionTo(true)
    
        //Check to see if the game has gone over the current set totalRounds
        if gameManager.currentRound <= gameManager.totalRounds {
            gameManager.currentRound += 1
            //Generate a random number for the switch statment, and for the facts
            let randomNumberForFactSet = GKRandomSource.sharedRandom().nextInt(upperBound: gameManager.totalSetsOfFacts)
            
            //Switch on the random number to get a random set of facts.
            switch(randomNumberForFactSet) {
            case 0:
                factLabel1.text = "\(gameManager.theGame.setOfFacts1[2].fact)"
                factLabel2.text = "\(gameManager.theGame.setOfFacts1[1].fact)"
                factLabel3.text = "\(gameManager.theGame.setOfFacts1[3].fact)"
                factLabel4.text = "\(gameManager.theGame.setOfFacts1[0].fact)"
            case 1:
                factLabel1.text = "\(gameManager.theGame.setOfFacts2[3].fact)"
                factLabel2.text = "\(gameManager.theGame.setOfFacts2[1].fact)"
                factLabel3.text = "\(gameManager.theGame.setOfFacts2[0].fact)"
                factLabel4.text = "\(gameManager.theGame.setOfFacts2[2].fact)"
            case 2:
                factLabel1.text = "\(gameManager.theGame.setOfFacts3[0].fact)"
                factLabel2.text = "\(gameManager.theGame.setOfFacts3[3].fact)"
                factLabel3.text = "\(gameManager.theGame.setOfFacts3[2].fact)"
                factLabel4.text = "\(gameManager.theGame.setOfFacts3[1].fact)"
            case 3:
                factLabel1.text = "\(gameManager.theGame.setOfFacts4[0].fact)"
                factLabel2.text = "\(gameManager.theGame.setOfFacts4[3].fact)"
                factLabel3.text = "\(gameManager.theGame.setOfFacts4[2].fact)"
                factLabel4.text = "\(gameManager.theGame.setOfFacts4[1].fact)"
            case 4:
                factLabel1.text = "\(gameManager.theGame.setOfFacts5[1].fact)"
                factLabel2.text = "\(gameManager.theGame.setOfFacts5[3].fact)"
                factLabel3.text = "\(gameManager.theGame.setOfFacts5[2].fact)"
                factLabel4.text = "\(gameManager.theGame.setOfFacts5[0].fact)"
            case 5:
                factLabel1.text = "\(gameManager.theGame.setOfFacts6[2].fact)"
                factLabel2.text = "\(gameManager.theGame.setOfFacts6[3].fact)"
                factLabel3.text = "\(gameManager.theGame.setOfFacts6[0].fact)"
                factLabel4.text = "\(gameManager.theGame.setOfFacts6[1].fact)"
            case 6:
                factLabel1.text = "\(gameManager.theGame.setOfFacts7[0].fact)"
                factLabel2.text = "\(gameManager.theGame.setOfFacts7[3].fact)"
                factLabel3.text = "\(gameManager.theGame.setOfFacts7[2].fact)"
                factLabel4.text = "\(gameManager.theGame.setOfFacts7[1].fact)"
            case 7:
                factLabel1.text = "\(gameManager.theGame.setOfFacts8[2].fact)"
                factLabel2.text = "\(gameManager.theGame.setOfFacts8[3].fact)"
                factLabel3.text = "\(gameManager.theGame.setOfFacts8[0].fact)"
                factLabel4.text = "\(gameManager.theGame.setOfFacts8[1].fact)"
            case 8:
                factLabel1.text = "\(gameManager.theGame.setOfFacts9[3].fact)"
                factLabel2.text = "\(gameManager.theGame.setOfFacts9[0].fact)"
                factLabel3.text = "\(gameManager.theGame.setOfFacts9[1].fact)"
                factLabel4.text = "\(gameManager.theGame.setOfFacts9[2].fact)"
            case 9:
                factLabel1.text = "\(gameManager.theGame.setOfFacts10[1].fact)"
                factLabel2.text = "\(gameManager.theGame.setOfFacts10[2].fact)"
                factLabel3.text = "\(gameManager.theGame.setOfFacts10[3].fact)"
                factLabel4.text = "\(gameManager.theGame.setOfFacts10[0].fact)"
            default: print("You have hit the default statement")
            }
            
            //Re-hide the buttons
            nextRoundSuccessButton.isHidden = true
            nextRoundFailButton.isHidden = true
            
            //Reset the timer back to the allowed round time in seconds then start the timer again
            totalTime = 60
            startTimer()
        } else {
            //Game has exceeded the max rounds. Need to show EndGame stats. Maybe on a new view?
            
            shakeToCompleteLabel.isHidden = true
            timerLabel.isHidden = true
            nextRoundFailButton.isHidden = true
            nextRoundSuccessButton.isHidden = true
            
            //Show Score button and make the edges rounded
            showScoreButton.layer.cornerRadius = 10.0
            showScoreButton.isHidden = false
            
            toggleEnableButtonInteractionTo(false)
            
            //Clear label text
            factLabel1.text = ""
            factLabel2.text = ""
            factLabel3.text = ""
            factLabel4.text = ""
        }
    }
    
    //code to toggle on button interaction on and off
    func toggleEnableButtonInteractionTo(_ bool: Bool) {
        downButton.isUserInteractionEnabled = bool
        firstUpButton.isUserInteractionEnabled = bool
        firstDownButton.isUserInteractionEnabled = bool
        secondUpButton.isUserInteractionEnabled = bool
        secondDownButton.isUserInteractionEnabled = bool
        upButton.isUserInteractionEnabled = bool
    }
    
    // Helper methods for Timer
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
        
    @objc func updateTime() {
            shakeToCompleteLabel.isHidden = false
            timerLabel.isHidden = false
            timerLabel.text = "\(totalTime)"
            
            if totalTime != 0 {
                totalTime -= 1
            } else {
                endTimer()
                
                if let fact1 = factLabel1.text, let fact2 = factLabel2.text, let fact3 = factLabel3.text, let fact4 = factLabel4.text {
                    gameManager.theGame.currentOrderOfFacts.append(Fact(fact: fact1))
                    gameManager.theGame.currentOrderOfFacts.append(Fact(fact: fact2))
                    gameManager.theGame.currentOrderOfFacts.append(Fact(fact: fact3))
                    gameManager.theGame.currentOrderOfFacts.append(Fact(fact: fact4))
                }
                checkFactOrder()
                gameManager.theGame.currentOrderOfFacts.removeAll()
            }
        }
        
    func endTimer() {
            countdownTimer.invalidate()
    }
}//End of View Controller
