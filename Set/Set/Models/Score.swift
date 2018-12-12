//
//  Score.swift
//  Set
//
//  Created by Marten Biesheuvel on 08/11/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import Foundation

struct Score: Codable {
    // MARK: properties
    let score: Int
    let amountOfSets: Int
    let time: Int?
    let date: String
}
