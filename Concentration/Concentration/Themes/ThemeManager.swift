//
//  ThemeManager.swift
//  Concentration
//
//  Created by Marten Biesheuvel on 27/09/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import Foundation

class ThemeManager {
    
    var currentTheme: ThemeProtocol
    private var themes: [String: ThemeProtocol] = [
        "SmileyTheme": SmileyTheme(),
        "AnimalTheme": AnimalTheme(),
        "FlagTheme": FlagTheme()]
    
    init() {
        let themeArray = Array(themes.values)
        let randomThemeIndex = themeArray.index(themeArray.startIndex, offsetBy: themeArray.count.arc4random)
        currentTheme = Array(themes.values)[randomThemeIndex]
    }
}
