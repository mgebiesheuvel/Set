//
//  SetTests.swift
//  SetTests
//
//  Created by Marten Biesheuvel on 24/10/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import XCTest
@testable import Set

class SetTests: XCTestCase {
    
    func testNumberOfCardsOnBoard_atStartUp_shouldReturn12() {
        let sut = Set()
        XCTAssertEqual(sut.cardsOnBoard.count, 12)
    }
    
    func testAddCardsOnBoard_add3Cards_shouldBe15CardsOnBoard() {
        var sut = Set()
        sut.addCardsOnBoard(3)
        
        XCTAssertEqual(sut.cardsOnBoard.count, 15)
    }
    
    func testAddCardsOnBoard_add50Cards_shouldBe24CardsOnBoard() {
        var sut = Set()
        sut.addCardsOnBoard(50)
        
        XCTAssertEqual(sut.cardsOnBoard.count, 24)
    }
}
