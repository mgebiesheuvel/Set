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
    private let cardFaceColor: UIColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1) // 246 246 246
    private let shadowColor: UIColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1) // 230 230 230
    private let inSelectionShadowColor: UIColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1) // 236 60 26
    private let inSelectionBorderColor: UIColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1) // 236 60 26
    private let borderColor: UIColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 0) // 230 230 230
    
    // MARK: properties
    private var inSelection: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.backgroundColor = cardFaceColor.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = frame.height / 2
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 0)
        
        drawState()
    }
    
    private func drawState() {
        layer.borderColor = inSelection ? inSelectionBorderColor.cgColor : borderColor.cgColor
        layer.shadowColor = inSelection ? inSelectionShadowColor.cgColor : shadowColor.cgColor
    }
    
    // MARK: public interface
    func setSelectedState(with state: Bool) {
        inSelection = state
        drawState()
    }
    
    func show(with cardFace: NSMutableAttributedString) {
        self.setAttributedTitle(cardFace, for: UIControl.State.normal)
    }
}
