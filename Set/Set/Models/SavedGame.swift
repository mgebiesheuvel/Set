//
//  SavedGame.swift
//  Set
//
//  Created by Marten Biesheuvel on 29/11/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import Foundation

struct SavedGame: Codable {
    let deck: [Card]
    let board: [Card]
    let score: Int
    let time: Int
}
