//
//  Concentration.swift
//  concentration
//
//  Created by Einar Balan on 8/13/19.
//  Copyright © 2019 Einar Balan. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    
    var flipCount: Int = 0
    var score: Int = 0
    
    private var indexOfOnlyFaceUpCard: Int? {
        get {
            let faceUpCardsIndices = cards.indices.filter { return cards[$0].isFaceUp } // get array of all cards that are face up
            return faceUpCardsIndices.oneAndOnly // return card index if only one, otherwise nil
        }
        
        set {
            for i in cards.indices {
                cards[i].isFaceUp = (i == newValue)
            }
        }
    }
    
    init (numPairs: Int) {
        assert(numPairs > 0, "Concentration.init, pairs of cards must be greater than 0")
        
        //populate cards array
        for _ in 1...numPairs {
            let card = Card()
            cards += [card, card]
        }
        
        //shuffle cards in array
        for index in cards.indices {
            var tempCard = Card()
            let randIndex = Int.random(in: cards.indices)
            
            tempCard = cards[randIndex]
            cards[randIndex] = cards[index]
            cards[index] = tempCard
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard, Index out of bounds")
        if (!cards[index].isMatched) {
            if (indexOfOnlyFaceUpCard != index) {
                flipCount += 1 // only increment flip count if card is visible (i.e. not matched) and the card was not previously selected
                if let matchIndex = indexOfOnlyFaceUpCard{
                    //only one card is selected and new card was chosen, check if the cards match
                    checkMatch(index: index, matchIndex: matchIndex)
                    cards[index].isFaceUp = true
                }
                else {
                    //no cards or two cards already selected
                    indexOfOnlyFaceUpCard = index
                    
                }
                cards[index].isSeen = true // will decrement score if chosen again without match
            }
        }
        else {
            //if the card is matched already, turn it face down
            indexOfOnlyFaceUpCard = nil
        }
        
    }
    
    mutating private func checkMatch(index: Int, matchIndex: Int) {
        if (cards[index] == cards[matchIndex]) { // they match, add score
            cards[index].isMatched = true
            cards[matchIndex].isMatched = true
            score += 2
        }
        else if (cards[index].isSeen){ //no match and card has been seen, decrement score
            score -= 1
        }
    }
    
    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
