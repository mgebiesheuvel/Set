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
    var points: Int = 0
    
    // MARK: public interface
    mutating func addMatch() {
        points += matchPoints
    }
    
    mutating func addMismatch() {
        points -= mismatchPoints
    }
    
    mutating func addCheat() {
        points -= cheatPoints
    }
    
    func calcScore(time: Int) -> Int {
        return points * (time / 100)
    }
}
