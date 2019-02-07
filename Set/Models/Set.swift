//
//  Set.swift
//  Set
//
//  Created by Marten Biesheuvel on 15/10/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import Foundation

struct Set {
    
    // MARK: defaults
    internal let maxNumberOfAllowedCardsOnBoard = 12
    internal let numberOfCardsInSet = 3
    internal let numberOfSetsOnBoardAllowedForCheating = 1
   
    // MARK: properties
    var scoreBoard = ScoreBoard()
    var timer = GameTimer()
    var deck = [Card]()
    var board = [Card]()
    
    // MARK: public interface
    
    // MARK: computed properties
    var cardsOnBoard: [Card] { return board.filter { !$0.isMatched }}
    var cardsInSelection: [Card] { return board.filter { $0.isSelected }}
    var foundSets: Int { return (board.filter { $0.isMatched }.count / numberOfCardsInSet)}
    var numberOfSetsOnBoard: Int { return getSetsOnBoard().count }
    var cardsInHint: [Card] { return board.filter { $0.inHint && !$0.isMatched }}
    var numberOfShownHintCard = 0
    
    init () {
        var identifier: Int = 0
        for color in Card.CardColor.allValues {
            for shading in Card.CardShading.allValues {
                for symbol in Card.CardSymbol.allValues {
                    for number in Card.CardNumber.allValues {
                        deck.append(Card(identifier: identifier, color: color, number: number, shading: shading, symbol: symbol))
                        identifier += 1
                    }
                }
            }
        }
        
        deck.shuffle()
        addCardsOnBoard(amount: maxNumberOfAllowedCardsOnBoard)
    }
    
    mutating func addCardsOnBoard(amount: Int) {
        guard amount <= maxNumberOfAllowedCardsOnBoard else { return }
        var tempBoard = board
        
        // add the amount of card
        for index in amount.reversed() {
            if deck.indices.contains(index) {
                tempBoard.append(deck.remove(at: index))
            }
        }
        
        board = tempBoard
        
        // board must at least contain one set
        if numberOfSetsOnBoard == 0 {
            board.removeLast(numberOfCardsInSet) // remove last three
            deck.shuffle()
            addCardsOnBoard(amount: numberOfCardsInSet) // try to add three new cards
        }
    }
    
    mutating func giveHint() {
        if cardsInHint.count == 0 {
            if let firstHintSerie: [Card] = getSetsOnBoard().first {
                for card: Card in firstHintSerie {
                    card.addToHint()
                }
            }
        }
        print(cardsInHint)
        cardsInHint[numberOfShownHintCard].select()
        numberOfShownHintCard += 1
        
        if numberOfShownHintCard == 3 {
            numberOfShownHintCard = 0
        }
    }
    
    mutating func chooseCard(atIndex index: Int) {
        let currentNumberOfCards = cardsOnBoard.count
        
        if cardsInSelection.count >= numberOfCardsInSet {
            for card in cardsInSelection {
                card.deselect()
            }
        }
        
        if cardsOnBoard.indices.contains(index) {
            let card = cardsOnBoard[index]
            
            if !card.isSelected {
                card.select()
            } else {
                card.deselect()
            }
            
            if cardsInSelection.count == numberOfCardsInSet {
                if isSet(cardsInSelection) {
                    for card in cardsInSelection {
                        card.match()
                    }
                    
                    scoreBoard.calcScore(timeNeeded: timer.getTimeNeeded())
                    
                    if currentNumberOfCards <= maxNumberOfAllowedCardsOnBoard {
                        addCardsOnBoard(amount: numberOfCardsInSet) // replace cards in valid set by new ones
                    }
                } else {
                    scoreBoard.addMismatch()
                }
            }
        }
    }
    
    // MARK: private interface
    private func getSetsOnBoard () -> [[Card]] {
        var result = [[Card]]()
        
        if cardsOnBoard.count >= numberOfCardsInSet {
            for i in 0..<cardsOnBoard.count {
                for j in (i+1)..<cardsOnBoard.count {
                    for k in (j+1)..<cardsOnBoard.count {
                        let cards = [cardsOnBoard[i], cardsOnBoard[j], cardsOnBoard[k]]
                        
                        if isSet(cards) {
                            result.append(cards)
                        }
                    }
                }
            }
        }
        return result
    }
    
    private func isSet(_ cards: [Card]) -> Bool {
        guard cards.count == numberOfCardsInSet else { return false }
    
        var colors = [Card.CardColor](),
            numbers = [Card.CardNumber](),
            shadings = [Card.CardShading](),
            symbols = [Card.CardSymbol]()
        
        for card in cards {
            colors.append(card.color)
            numbers.append(card.number)
            shadings.append(card.shading)
            symbols.append(card.symbol)
        }
        
        return compare(&colors, &numbers, &shadings, &symbols)
    }
    
    fileprivate func compare(_ colors: inout [Card.CardColor], _ numbers: inout [Card.CardNumber], _ shadings: inout [Card.CardShading], _ symbols: inout [Card.CardSymbol]) -> Bool {
        return !(colors.unique().count == 2 || numbers.unique().count == 2 ||
            shadings.unique().count == 2 || symbols.unique().count == 2)
    }
}
