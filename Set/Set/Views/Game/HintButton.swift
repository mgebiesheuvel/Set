//
//  HintButton.swift
//  Set
//
//  Created by Marten Biesheuvel on 28/12/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import UIKit

@IBDesignable class HintButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }
    
    override func awakeFromNib() {
        refreshCorners(value: cornerRadius)
    }
}
