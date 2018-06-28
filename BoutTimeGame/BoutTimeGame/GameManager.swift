//
//  GameManager.swift
//  BoutTimeGame
//
//  Created by David Oliveira on 6/23/18.
//  Copyright © 2018 David Oliveira. All rights reserved.
//
import UIKit
import GameKit

class GameManager {
    var theGame = Game()
    var currentRound = 1
    var totalRounds = 6
    var totalSetsOfFacts = 10
    var eventsPerRound = 4
    var totalScore = 0
    
    var correctDing: SystemSoundID = 0
    var incorrectBuzz: SystemSoundID = 1
    var buttonPress: SystemSoundID = 2
    
    func loadCorrectDingSound() {
        let path = Bundle.main.path(forResource: "CorrectDing", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &correctDing)
    }
    
    func loadIncorrectBuzzSound() {
        let path = Bundle.main.path(forResource: "IncorrectBuzz", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &incorrectBuzz)
    }
    
    func loadButtonPressSound() {
        let path = Bundle.main.path(forResource: "ButtonPress", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &buttonPress)
    }
    
    func playCorrectDingSound() {
        AudioServicesPlaySystemSound(correctDing)
    }
    
    func playIncorrectBuzzSound() {
        AudioServicesPlaySystemSound(incorrectBuzz)
    }
    
    func playButtonPressSound() {
        AudioServicesPlaySystemSound(buttonPress)
    }
    
    func setLabelRoundedEdges(for factLabel1: UILabel, factLabel2: UILabel, factLabel3: UILabel, factLabel4: UILabel) {
        factLabel1.layer.masksToBounds = true
        factLabel1.layer.cornerRadius = 5.0
        
        factLabel2.layer.masksToBounds = true
        factLabel2.layer.cornerRadius = 5.0
        
        factLabel3.layer.masksToBounds = true
        factLabel3.layer.cornerRadius = 5.0
        
        factLabel4.layer.masksToBounds = true
        factLabel4.layer.cornerRadius = 5.0
    }
    
    func setButtonsAsTopLayer(withView view: UIView, for downButton: UIButton, firstUpButton: UIButton, firstDownButton: UIButton, secondUpButton:   UIButton,
                              secondDownButton: UIButton, upButton: UIButton) {
        view.bringSubview(toFront: downButton)
        view.bringSubview(toFront: firstUpButton)
        view.bringSubview(toFront: firstDownButton)
        view.bringSubview(toFront: secondUpButton)
        view.bringSubview(toFront: secondDownButton)
        view.bringSubview(toFront: upButton)
    }
    
    func setImagesForHighlightedButtons(downButton: UIButton, firstUpButton: UIButton, firstDownButton: UIButton,secondUpButton: UIButton,
                                        secondDownButton: UIButton, upButton: UIButton) {
        // Setting Highlighted Images
        downButton.setImage(#imageLiteral(resourceName: "down_full_selected"), for: UIControlState.highlighted)
        
        firstUpButton.setImage(#imageLiteral(resourceName: "up_half_selected"), for: UIControlState.highlighted)
        firstDownButton.setImage(#imageLiteral(resourceName: "down_half_selected"), for: UIControlState.highlighted)
        secondUpButton.setImage(#imageLiteral(resourceName: "up_half_selected"), for: UIControlState.highlighted)
        secondDownButton.setImage(#imageLiteral(resourceName: "down_half_selected"), for: UIControlState.highlighted)
        
        upButton.setImage(#imageLiteral(resourceName: "up_full_selected"), for: UIControlState.highlighted)
    }
}

