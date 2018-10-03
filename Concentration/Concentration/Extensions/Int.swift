//
//  Int.swift
//  Concentration
//
//  Created by Marten Biesheuvel on 03/10/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import Foundation

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        return 0
    }
}
