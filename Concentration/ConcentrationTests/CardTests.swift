//
//  CardTests.swift
//  ConcentrationTests
//
//  Created by Marten Biesheuvel on 25/09/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import XCTest
@testable import Concentration

class CardTests: XCTestCase {

    func testDefaultValues_newCard_FaceUpIsFalse() {
        let card = Card()
        XCTAssertFalse(card.isFaceUp)
    }
    
    func testDefaultValues_newCard_IsMatchedIsFalse() {
        let card = Card()
        XCTAssertFalse(card.isMatched)
    }
    
    func testEquals_twoEqualCards_returnsTrue() {
        let card1 = Card()
        let card2 = card1
        
        XCTAssertTrue(card1 == card2)
    }
    
    func testEquals_twoDifferentCards_returnsFalse() {
        let card1 = Card()
        let card2 = Card()
        
        XCTAssertFalse(card1 == card2)
    }
}
