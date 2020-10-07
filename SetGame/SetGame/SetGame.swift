//  SetGame.swift
//  SetGame
//  Created by Francisco Cuesta on 9/25/20.
//  Copyright © 2020 Francisco Cuesta. All rights reserved.

import Foundation
class SetGame {
    var availCards = SetCardDeck()
    var cardsInGame = [SetCard]()
    var chosenCards = [SetCard]()
    var score = 0
    /// Cards from last matched set
    private(set) var matchedCards = [SetCard]()
    
    // Counter of successful matches
    private(set) var matchedSets = 0
    init() {newGame()}
    
    
    func newGame() {
        score = 0
        availCards=SetCardDeck()
        cardsInGame=[SetCard]()
        for _ in 1...12 {
            if let card=availCards.dealCard(){
               cardsInGame.append(card)
            }
            
        }
        print("Add \(cardsInGame.count) cards from deck to game")
    }
    
    
    
    
    
    
    func addCards(numOfCardsToSelect numberOfCards: Int) {
         for _ in 1...numberOfCards {
                   if let card=availCards.dealCard(){
                      cardsInGame.append(card)
                   }
               }
    }
    
    func cardIsChosen(card: SetCard) -> Bool {
        return chosenCards.firstIndex(of: card) != nil
    }
    
    
    
    func isSet() -> Bool {
        //If two are... and one is not, then it is not a 'Set'.
        if chosenCards.count != 3 {
            return false
        }
        
        if chosenCards[0].color == chosenCards[1].color {
        if chosenCards[0].color != chosenCards[2].color {
            return false
            
            }
            
        } else if chosenCards[1].color == chosenCards[2].color {
            return false
        } else if (chosenCards[0].color == chosenCards[2].color) {
            return false
        }
        
        if chosenCards[0].shade == chosenCards[1].shade{
        if chosenCards[0].shade != chosenCards[2].shade {
            return false
            }
            
        } else if chosenCards[1].shade == chosenCards[2].shade {
            return false
        } else if (chosenCards[0].shade == chosenCards[2].shade) {
            return false
        }
        
        if chosenCards[0].shape == chosenCards[1].shape {
        if chosenCards[0].shape != chosenCards[2].shape {
            return false
            }
        } else if chosenCards[1].shape == chosenCards[2].shape {
            return false
        } else if (chosenCards[0].shape == chosenCards[2].shape) {
            return false
        }
        return true
    }
    
    func select(card: SetCard){
    if chosenCards.count == 3 && isSet() {
             chosenCards.forEach {
                 if let selectedCardInGameIndex = cardsInGame.firstIndex(of: $0) {
                     cardsInGame.remove(at: selectedCardInGameIndex)
                         if availCards.count() > 0 {
                             let selectedCard = cardsInGame.remove (at: availCards.count().arc4Random())
                                     cardsInGame.insert(selectedCard, at: selectedCardInGameIndex)
                     }
                 }
                 
             }
             chosenCards.removeAll()
             score += 3
         } else if chosenCards.count == 3 && !isSet() {
             chosenCards.removeAll()
             score -= 2
         }
         
         if let cardToSelect = chosenCards.firstIndex(of: card) {
             // Card is already selected, so remove it from the selection
             chosenCards.remove(at: cardToSelect)
         } else {
             chosenCards.append(card)
         }
         
         print("Selected \(chosenCards.count) cards")
         print("Cards available in deck \(String(describing: availCards.count)) cards")
         print("Cards in game \(cardsInGame.count) cards")
     }
    
    
    
   
    
}



extension Int {
    func arc4Random() -> Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
