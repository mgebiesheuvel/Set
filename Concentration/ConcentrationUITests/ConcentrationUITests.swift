//
//  ConcentrationUITests.swift
//  ConcentrationUITests
//
//  Created by Marten Biesheuvel on 25/09/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import XCTest

class ConcentrationUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
    }

    func testCard_atStartUp_expext12Cards() {
        XCTAssertTrue(app.buttons.count == 12)
    }
    
    func testFlipCountLabel_atStartUp_flipCountLabelExists() {
        XCTAssertTrue(app.staticTexts["Flips: 0"].exists)
    }
}
