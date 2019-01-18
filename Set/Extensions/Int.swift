//
//  Int.swift
//  Set
//
//  Created by Marten Biesheuvel on 15/10/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import Foundation

extension Int: Sequence {
    public func makeIterator() -> CountableRange<Int>.Iterator {
        return (0..<self).makeIterator()
    }
}
