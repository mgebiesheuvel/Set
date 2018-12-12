//
//  GameButton.swift
//  Set
//
//  Created by Marten Biesheuvel on 15/10/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import UIKit

class GameButton: UIButton {
    
    // MARK: defaults
    private let cornerRadius: CGFloat = 5.0
    private let borderWidth: CGFloat = 3.0

    // MARK: properties
    private let enabledColor: CGColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    private let disabledColor: CGColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if !self.isEnabled {
            self.setTitleColor(UIColor(cgColor: disabledColor), for: .normal)
        } else {
            self.setTitleColor(UIColor(cgColor: enabledColor), for: .normal)
        }
    
        self.clipsToBounds = true
    }
    
    // MARK: public interface
    func disable() {
        self.isEnabled = false
    }
    
    func enable() {
        self.isEnabled = true
    }
}
