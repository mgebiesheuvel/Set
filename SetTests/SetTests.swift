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
    
    func testAddCardsOnBoard_add12Cards_shouldBeAtLeastOneSetOnBoard() {
        var sut = Set()
        sut.addCardsOnBoard(amount: 12)
        
        XCTAssertTrue(sut.numberOfSetsOnBoard > 0)
    }
    
    func testAddCardsOnBoard_add50Cards_shouldBe0CardsOnBoard() {
        var sut = Set()
        sut.addCardsOnBoard(amount: 50)
        
        XCTAssertEqual(sut.cardsOnBoard.count, 12)
    }
}
