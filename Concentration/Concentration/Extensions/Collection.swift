//
//  Collection.swift
//  Concentration
//
//  Created by Marten Biesheuvel on 03/10/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import Foundation

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
