//  SetCardDeck.swift
//  SetGame
//
//  Created by Francisco Cuesta on 9/25/20.
//  Copyright © 2020 Francisco Cuesta. All rights reserved.
//

import Foundation

// setcarddeck is a struct
struct SetCardDeck
{
    //array of setcard with count 0
    var deck = [SetCard]()
  //  var property = [String]()

    // func that finds the count
    func count() -> Int{
        return deck.count
    }
    
    //if deck.count = 0 then deck is empty
    func isEmpty() -> Bool{
        return deck.count == 0 ? true : false
    }
    
    
//optional ? returns a card if there is a card in the deck
    mutating func dealCard() -> SetCard?
    {  //  if  true = 0 then i returns a nill
        return self.isEmpty() ? nil : deck.remove(at: 0)
    }

    //initiates array of all enums
    init() {
    for color in SetCard.Colors.all{
        for shape in SetCard.Shapes.all{
            for shade in SetCard.Shades.all{
                for count in 1...3  {
                    deck += [ SetCard(shape: shape, shade: shade, color: color, count: count)]
                    }
                }
            }
        }
        //shuffle
        for _ in 1...10{
            for index in deck.indices {
                let randomIndex = Int(arc4random_uniform(UInt32(index)))
                let card = deck.remove(at: randomIndex)
                deck.append(card)
            }
        }
    }
    
    
}


