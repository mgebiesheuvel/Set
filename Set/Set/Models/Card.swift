//
//  Card.swift
//  Set
//
//  Created by Marten Biesheuvel on 09/10/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import Foundation

class Card {
    
    // MARK: properties
    var color: CardColor
    var number: CardNumber
    var shading: CardShading
    var symbol: CardSymbol
    
    var isSelected: Bool = false
    var isMatched: Bool = false
    
    init (color: CardColor, number: CardNumber, shading: CardShading, symbol: CardSymbol) {
        self.color = color
        self.number = number
        self.shading = shading
        self.symbol = symbol
    }
    
    // MARK: public interface
    func select() {
        isSelected = true
    }
    
    func deselect() {
        isSelected = false
    }
    
    func match () {
        isMatched = true
        deselect()
    }
    
    // MARK: card properties
    enum CardColor: Int, Hashable, CardProperty {
        case red = 1, green, blue
        
        static let allValues = [red, green, blue]
        var index: Int {
            return rawValue - 1
        }
    }
    
    enum CardNumber: Int, Hashable, CardProperty {
        case one = 1 , two, three
        
        static let allValues = [one, two, three]
        var index: Int {
            return rawValue - 1
        }
    }
    
    enum CardShading: Int, Hashable, CardProperty {
        case open = 1, striped, solid
        
        static let allValues = [open, striped, solid]
        var index: Int {
            return rawValue - 1
        }
    }
    
    enum CardSymbol: Int, Hashable, CardProperty {
        case diamond = 1, circle, triangle
        
        static let allValues = [diamond, circle, triangle]
        var index: Int {
            return rawValue - 1
        }
    }
}
