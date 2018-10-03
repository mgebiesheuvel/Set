//
//  ThemeManager.swift
//  Concentration
//
//  Created by Marten Biesheuvel on 27/09/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import Foundation

struct ThemeManager {
    
    var currentTheme: ThemeProtocol!
    let themes: [String: ThemeProtocol] = [
        "SmileyTheme": SmileyTheme(),
        "AnimalTheme": AnimalTheme(),
        "FlagTheme": FlagTheme(),
        "ChineseTheme": ChineseTheme()]
    
    init() {
        setTheme(nil)
    }
    
    mutating func setTheme(_ name: String?) {
        if let themeName = name {
            if themes[themeName] != nil {
                currentTheme = themes[themeName]!
            }
        } else {
            let themeArray = Array(themes.values)
            let randomThemeIndex = themeArray.index(themeArray.startIndex, offsetBy: themeArray.count.arc4random)
            
            currentTheme = themeArray[randomThemeIndex]
        }
    }
}
