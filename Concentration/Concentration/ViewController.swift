//
//  ViewController.swift
//  Concentration
//
//  Created by Marten Biesheuvel on 10/09/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    private var numberOfPairsOfCards: Int { return (cardButtons.count + 1) / 2 }
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    private lazy var themeManager = ThemeManager()
    private var themePickerData = [String]()
    private var selectedTheme = ""
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet weak var themePicker: UIPickerView!
    
    @IBAction func startNewGame(_ sender: Any) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        emoji = [Card: String]()
        themeManager.setTheme(selectedTheme)
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    override func viewDidLoad() {
        for btn in cardButtons {
            btn.backgroundColor = themeManager.currentTheme.color
        }
        
        initThemePicker()
    }
    
    fileprivate func initThemePicker() {
        themePickerData = Array(themeManager.themes.keys)
        themePicker.delegate = self
        themePicker.dataSource = self
        selectedTheme = themePickerData[0] // set first option as selected theme
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
        
        flipCountLabel.text = "Flips: \(game.scoreBoard.flipCount)"
        scoreLabel.text = "Score: \(game.scoreBoard.score)"
    }
    
    private var emoji = [Card: String]()
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, themeManager.currentTheme.cardFaceChoices.count > 0 {
            emoji[card] = themeManager.currentTheme.getRandomCardFace()
        }
        return emoji[card] ?? "?"
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return themePickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return themePickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTheme = themePickerData[row]
    }
}
