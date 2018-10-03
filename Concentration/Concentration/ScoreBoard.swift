//
//  ScoreBoard.swift
//  Concentration
//
//  Created by Marten Biesheuvel on 28/09/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import Foundation

class ScoreBoard {
    
    private(set) var flipCount: Int = 0
    private(set) var score: Int = 0
    private var flippedCards: [Card] = [Card]()
    
    func addFlip(with card:Card) {
        flipCount += 1
        flippedCards.append(card)
    }
    
    func addMatch(for card: Card) {
        score += calcPoints(flippedCards.filter { $0 == card })
    }
    
    func calcPoints(_ cards: [Card]) -> Int {
        switch cards.count {
        case 2:
            return 5
        case 3:
            return 4
        case 4:
            return 3
        default: // also the case for more than 3
            return 2
        }
    }
}
