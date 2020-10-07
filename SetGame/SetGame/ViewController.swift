//
//  ViewController.swift
//  SetGame
//
//  Created by Francisco Cuesta on 9/25/20.
//  Copyright © 2020 Francisco Cuesta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dealThreeMoreCardsButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    var game = SetGame()
    
    @IBOutlet weak var buttons: UIButton!
    
   
    override func viewDidLoad() {
    super.viewDidLoad()
        resetButtons()
        updateGameView()
        cardButtons[0].setAttributedTitle(NSAttributedString(string: ""), for: UIControl.State.normal)
        // Do any additional setup after loading the view.
      }
    func resetButtons() {
        for buttonIndex in cardButtons.indices {
        let button = cardButtons[buttonIndex]
        button.deselect()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25.0)
        button.layer.cornerRadius = 10
        button.backgroundColor = #colorLiteral(red: 1, green: 0.5768225789, blue: 0, alpha: 0)
        button.layer.borderColor =  #colorLiteral(red: 1, green: 0.5768225789, blue: 0, alpha: 0)
        button.setAttributedTitle(nil, for: UIControl.State.normal)
        cardButtons![0].setAttributedTitle(NSAttributedString(string: ""), for: UIControl.State.normal)
        
          }
      }
      @IBAction private func selectCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender) {
                    if cardIndex < game.cardsInGame.count {
                        game.select(card: game.cardsInGame[cardIndex])
                        
                        }
                        updateGameView()
                    }
                }
     @IBAction func newGame(){
        
        game.newGame()
        resetButtons()
        updateGameView()
        dealThreeMoreCardsButton.isEnabled = true
      }
    
    @IBAction func draw3CardsFromDeck() {
        game.addCards(numOfCardsToSelect: 3)
        updateGameView()
            if game.cardsInGame.count >= 24 {
                   dealThreeMoreCardsButton.isEnabled = false
        }
    }
    private func updateGameView() {
        var cardButtonIndex = 0
        resetButtons()
        scoreLabel.text = "Score: \(game.score)"
            
        for card in game.cardsInGame {
            let button = cardButtons[cardButtonIndex]
            SetCard.renderCard (cardToRender: card, onButton:button, selectButton: game.cardIsChosen(card: card), isSet: game.isSet())
            button.setAttributedTitle(card.attributedContents(),for:UIControl.State.normal)
                cardButtonIndex += 1
        }
    }
}


