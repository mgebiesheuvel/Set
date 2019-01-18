//
//  ScoreBoard.swift
//  Set
//
//  Created by Marten Biesheuvel on 24/10/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import Foundation

struct ScoreBoard {
    // MARK: defaults
    private let mismatchPoints = 6
    private let cheatPoints = 10
    
    // MARK: properties
    var score: Int = 0
    
    // MARK: public interface
    mutating func calcScore(timeNeeded: Int) {
        let calcScore = 1000 / timeNeeded
        score += calcScore > 1 ? calcScore : 1
    }
    
    mutating func addMismatch() {
        score -= mismatchPoints
    }
    
    mutating func addCheat() {
        score -= cheatPoints
    }
}
