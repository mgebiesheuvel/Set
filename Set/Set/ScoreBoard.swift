//
//  ScoreBoard.swift
//  Set
//
//  Created by Marten Biesheuvel on 24/10/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import Foundation

struct ScoreBoard {
    
    private let matchPoints = 5
    private let mismatchPoints = 3
    
    private(set) var score: Int = 0
    
    mutating func addMatch() {
        score += matchPoints
    }
    
    mutating func addMismatch() {
        score -= mismatchPoints
    }
}
