//
//  ViewController.swift
//  Concentration
//
//  Created by Marten Biesheuvel on 10/09/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
   
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    
    }
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("choosen card was not in cardButtons")
        }
    }
    
    private func updateFlipCountLabel() {
        flipCountLabel.attributedText = NSAttributedString(string: "Flips: \(flipCount)", attributes: [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)
        ])
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {

                if !card.isMatched {
                    button.setTitle("", for: UIControl.State.normal)
                }
                
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1450931079) : #colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)
            }
        }
    }
    
    private var emojiChoices = "😀😅😉😎🤓🤪🙄🤔😨😴😬😂"
    private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        return 0
    }
}
