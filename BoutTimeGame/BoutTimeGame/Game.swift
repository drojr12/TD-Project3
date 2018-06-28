//
//  Game.swift
//  BoutTimeGame
//
//  Created by David Oliveira on 6/23/18.
//  Copyright © 2018 David Oliveira. All rights reserved.
//

class Game {
    let setOfFacts1: [Fact]
    let setOfFacts2: [Fact]
    let setOfFacts3: [Fact]
    let setOfFacts4: [Fact]
    let setOfFacts5: [Fact]
    let setOfFacts6: [Fact]
    let setOfFacts7: [Fact]
    let setOfFacts8: [Fact]
    let setOfFacts9: [Fact]
    let setOfFacts10: [Fact]
    
    var currentOrderOfFacts: [Fact] = [Fact]()
    
    //Set up the facts when the Game object is made
    init() {
        let fact1 = Fact(fact: "Friday the 13th")
        let fact2 = Fact(fact: "Friday the 13th, The Final Chapter")
        let fact3 = Fact(fact: "Friday the 13th, Jason Lives")
        let fact4 = Fact(fact: "Jason X")
        
        let fact5 = Fact(fact: "The 1st movie theater opens")
        let fact6 = Fact(fact: "Walt Disney creates his 1st cartoon")
        let fact7 = Fact(fact: "Casablanca Premiers in theaters")
        let fact8 = Fact(fact: "Titanic becomes highest-grossing film of all time")
        
        let fact9 = Fact(fact: "Captain America: The First Avenger")
        let fact10 = Fact(fact: "Iron Man")
        let fact11 = Fact(fact: "The Incredible Hulk")
        let fact12 = Fact(fact: "Thor")
        
        let fact13 = Fact(fact: "Eggs are laid on plants")
        let fact14 = Fact(fact: "A Caterpillar Hatches")
        let fact15 = Fact(fact: "Pupa - The Transitioning Stage begins")
        let fact16 = Fact(fact: "Adult - Turns into a beautiful butterly")
        
        let fact17 = Fact(fact: "iPhone")
        let fact18 = Fact(fact: "iPhone 5S")
        let fact19 = Fact(fact: "iPhone SE")
        let fact20 = Fact(fact: "iPhone X")
        
        let fact21 = Fact(fact: "A Nightmare on Elm Street")
        let fact22 = Fact(fact: "Freddy's Dead: The Final Nightmare")
        let fact23 = Fact(fact: "Wes Craven's New Nightmare")
        let fact24 = Fact(fact: "Freddy vs. Jason")
        
        let fact25 = Fact(fact: "Harry Potter and the Sorcerer's Stone")
        let fact26 = Fact(fact: "Harry Potter and the Prisoner of Azkaban")
        let fact27 = Fact(fact: "Harry Potter and the Half-Blood Prince")
        let fact28 = Fact(fact: "Harry Potter and the Deathly Hallows")
        
        let fact29 = Fact(fact: "Windows 3.1")
        let fact30 = Fact(fact: "Windows 98")
        let fact31 = Fact(fact: "Windows ME")
        let fact32 = Fact(fact: "Windows XP")
        
        let fact33 = Fact(fact: "FORTRAN")
        let fact34 = Fact(fact: "Pascal")
        let fact35 = Fact(fact: "JavaScript")
        let fact36 = Fact(fact: "Swift")
        
        let fact37 = Fact(fact: "Beyonce: Dangerously in Love")
        let fact38 = Fact(fact: "Beyonce: I Am... Sasha Fierce")
        let fact39 = Fact(fact: "Beyonce: 4")
        let fact40 = Fact(fact: "Beyonce: Lemonade")
        
        self.setOfFacts1 = [fact1, fact2, fact3, fact4]
        self.setOfFacts2 = [fact5, fact6, fact7, fact8]
        self.setOfFacts3 = [fact9, fact10, fact11, fact12]
        self.setOfFacts4 = [fact13, fact14, fact15, fact16]
        self.setOfFacts5 = [fact17, fact18, fact19, fact20]
        self.setOfFacts6 = [fact21, fact22, fact23, fact24]
        self.setOfFacts7 = [fact25, fact26, fact27, fact28]
        self.setOfFacts8 = [fact29, fact30, fact31, fact32]
        self.setOfFacts9 = [fact33, fact34, fact35, fact36]
        self.setOfFacts10 = [fact37, fact38, fact39, fact40]
        
        
    }
}
