//
//  ThemeProtocol.swift
//  Concentration
//
//  Created by Marten Biesheuvel on 27/09/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import Foundation
import UIKit

protocol ThemeProtocol {
    
    var color: UIColor { get set }
    var emojiChoices: String { get set }
    
    mutating func getRandomEmoji() -> String
}

extension ThemeProtocol {
    mutating func getRandomEmoji() -> String {
        let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
        return  String(emojiChoices.remove(at: randomStringIndex))
    }
}
