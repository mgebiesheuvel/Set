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
    var cardFaceChoices: String { get set }
    
    mutating func getRandomCardFace() -> String
}

extension ThemeProtocol {
    mutating func getRandomCardFace() -> String {
        let randomStringIndex = cardFaceChoices.index(cardFaceChoices.startIndex, offsetBy: cardFaceChoices.count.arc4random)
        return  String(cardFaceChoices.remove(at: randomStringIndex))
    }
}
