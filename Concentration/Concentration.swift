//
//  Concentration.swift
//  Concentration
//
//  Created by Man Vu Minh on 2019-03-30.
//  Copyright © 2019 Man Vu. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    var areCurrentSelectedMatched: Bool?
    
    var score = 0
    
    var flipCount = 0
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            flipCount += 1
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if cards[matchIndex].isInvolvedInMismatched {
                        score -= 1
                    }
                    if cards[index].isInvolvedInMismatched {
                        score -= 1
                    }
                    
                    cards[matchIndex].isInvolvedInMismatched = true
                    cards[index].isInvolvedInMismatched = true
                }
                
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
                areCurrentSelectedMatched = nil
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
}
