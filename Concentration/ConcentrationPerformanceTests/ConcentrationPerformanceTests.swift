//
//  ConcentrationPerformanceTests.swift
//  ConcentrationPerformanceTests
//
//  Created by Marten Biesheuvel on 26/09/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import XCTest
@testable import Concentration

class ConcentrationPerformanceTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }

    func testPerformance() {
        self.measure {
            app.buttons.element(boundBy: 0).tap()
        }
    }
    
    func testPerformanceMeasureMetrics() {
        self.measureMetrics([XCTPerformanceMetric.wallClockTime], automaticallyStartMeasuring: false) {
            startMeasuring()
            XCUIApplication().buttons.element(boundBy: 0).tap()
            stopMeasuring()
        }
    }
}
