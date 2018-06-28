//
//  ScoreController.swift
//  BoutTimeGame
//
//  Created by David Oliveira on 6/25/18.
//  Copyright © 2018 David Oliveira. All rights reserved.
//

import UIKit

class ScoreController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    
    // properties to hold the score and round information
    var scoreText: String? = nil
    var totalRoundsText: String? = nil
    
    //A reference to the view controller that was passed in
    var viewController: ViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Check to see if scoreText and totalRoundsText have anything in them, if so assign it to the label's text
        if let scoreText = scoreText, let totalRoundsText = totalRoundsText {
            scoreLabel.text = scoreText + " / " + totalRoundsText
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Action for the play again button
    //dismiss the screen, then call resetGame method on the viewController
    @IBAction func playAgain(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        viewController?.resetGame()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
