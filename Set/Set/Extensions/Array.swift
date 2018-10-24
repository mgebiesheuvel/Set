//
//  Array.swift
//  Set
//
//  Created by Marten Biesheuvel on 24/10/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    mutating func unique() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
}
