//
//  CardButton.swift
//  Set
//
//  Created by Marten Biesheuvel on 15/10/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import UIKit

class CardButton: UIButton {
    
    // MARK: defaults
    private let cornerRadius: CGFloat = 5.0
    private let borderWidth: CGFloat = 3.0
    private let transparentColor: CGColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
    private let inSelectionBorderColor: CGColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    private let cardFaceColor: CGColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    // MARK: properties
    private var inSelection: Bool = false
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = inSelection ? inSelectionBorderColor : transparentColor
        self.clipsToBounds = true
    }
    
    // MARK: public interface
    func hide() {
        self.inSelection = false
        self.setAttributedTitle(nil, for: .normal)
        self.setTitle("", for: .normal)
        self.backgroundColor = UIColor(cgColor: transparentColor)
    }
    
    func show(with cardFace: NSMutableAttributedString) {
        self.setAttributedTitle(cardFace, for: UIControl.State.normal)
        self.backgroundColor = UIColor(cgColor: cardFaceColor)
    }
    
    func setSelectedState(with state: Bool) {
        inSelection = state
        setNeedsDisplay()
    }
}
