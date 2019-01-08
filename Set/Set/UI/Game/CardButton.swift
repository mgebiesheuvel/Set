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
    private let transparentColor: CGColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0)
    private let inSelectionBorderColor: CGColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)

    private let cardFaceColor: UIColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1) // 246 246 246
    private let borderColor: UIColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1) // 230 230 230
    
    // MARK: properties
    private var inSelection: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()

        layer.backgroundColor = cardFaceColor.cgColor
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = frame.height / 2
        layer.shadowColor = borderColor.cgColor
        layer.shadowRadius = 10
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0, height: 0)
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
        //self.backgroundColor = cardFaceColor
    }
    
    func setSelectedState(with state: Bool) {
        inSelection = state
        setNeedsDisplay()
    }
}
