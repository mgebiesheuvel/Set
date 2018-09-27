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
    private var themeManager = ThemeManager()
   
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
    
    override func viewDidLoad() {
        for btn in cardButtons {
            btn.backgroundColor = themeManager.currentTheme.color
        }
    }
    
    private func updateFlipCountLabel() {
        flipCountLabel.attributedText = NSAttributedString(string: "Flips: \(flipCount)", attributes: [
            .strokeWidth: 5.0,
            .strokeColor: themeManager.currentTheme.color
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
                
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1450931079) : themeManager.currentTheme.color
            }
        }
    }
    
    private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, themeManager.currentTheme.emojiChoices.count > 0 {
            emoji[card] = themeManager.currentTheme.getRandomEmoji()
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
