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
    private let matchPoints = 5
    private let mismatchPoints = 2
    private let cheatPoints = 3
    
    // MARK: properties
    private(set) var score: Int = 0
    
    // MARK: public interface
    mutating func addMatch() {
        score += matchPoints
    }
    
    mutating func addMismatch() {
        score -= mismatchPoints
    }
    
    mutating func addCheat() {
        score -= cheatPoints
    }
}
