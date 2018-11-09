//
//  ViewController.swift
//  Set
//
//  Created by Marten Biesheuvel on 09/10/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: user feedback
    var impact = UIImpactFeedbackGenerator()
    
    // MARK: defaults
    private let colors = [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)]
    private let shadings: [CGFloat] = [0.0, 0.4, 1.0]
    private let symbols = ["◆", "●", "▲"]
    
    // MARK: properties
    private var game = Set()
    
    // MARK: outlets
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var foundSetsLabel: UILabel!
    @IBOutlet weak var numberOfSetsOnBoardLabel: UILabel!
    @IBOutlet weak var addThreeCardsButton: GameButton!
    
    @IBAction func touchCardButton(_ sender: UIButton) {
        impact.impactOccurred() // give haptic feedback to the app user
        guard let index = cardButtons.index(of: sender) else { return }
        game.chooseCard(atIndex: index)
        updateViewFromModel()
    }
    
    @IBAction func touchAddThreeCardsButton(_ sender: UIButton) {
        impact.impactOccurred() // give haptic feedback to the app user
        game.cheatByAddingThreeExtraCards()
        updateViewFromModel()
    }
    
    @IBAction func touchEndGameButton(_ sender: UIButton) {
        impact.impactOccurred() // give haptic feedback to the app user
        
        let alert = UIAlertController(title: "Zeker weten?", message: "Het spel stopt en je score wordt niet opgeslagen.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ja", style: .default , handler: { (_) in
            self.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Annuleer", style: .default , handler: { (_) in }))
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewFromModel()
    }
    
    // MARK: private interface
    private func updateViewFromModel() {
        updateCardButtonsFromModel()
        updateAddThreeCardsButtonFromModel()
        updateFoundSetsLabel()
        updateScoreLabel()
        udateNumberOfSetsOnBoardLabel()
        checkGameIsOver()
    }
    
    private func checkGameIsOver() {
        if game.numberOfSetsOnBoard == 0 && game.deck.count == 0{
            let alert = UIAlertController(title: "Game Over!", message: "Het spel is voorbij. Er zijn geen sets meer op het bord.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Thnks!", style: .default , handler: { (_) in
                self.navigationController?.popViewController(animated: true)
                
                ScoreService().store(
                    score: Score(score: self.game.scoreBoard.score, amountOfSets: self.game.foundSets, date: DateTime().getCurrentDate(in: nil))
                )
            }))
            self.present(alert, animated: true)
        }
    }
    
    private func updateCardButtonsFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index] as! CardButton
            
            if game.cardsOnBoard.indices.contains(index) {
                let card = game.cardsOnBoard[index]
                let color = colors[card.color.index]
                    .withAlphaComponent(shadings[card.shading.index])

                button.show(with: NSMutableAttributedString(
                    string: String(
                        repeating: symbols[card.symbol.index],
                        count: card.number.rawValue),
                        attributes: [
                            .foregroundColor: color,
                            .strokeWidth: -10.0,
                            .strokeColor: colors[card.color.index]
                        ]
                    )
                )
                
                button.setSelectedState(with: card.isSelected)
                
            } else {
                button.hide()
            }
        }
    }
    
    private func updateAddThreeCardsButtonFromModel() {
        addThreeCardsButton?.setTitle("+3 kaarten (nog \(game.deck.count))", for: .normal)
        if game.cardsOnBoard.count == game.maxNumberOfAllowedCardsOnBoard || game.deck.count == 0 {
            addThreeCardsButton?.disable()
        } else {
            addThreeCardsButton?.enable()
        }
    }
    
    private func updateFoundSetsLabel() {
        foundSetsLabel.text = "Sets: \(game.foundSets)"
    }
    
    private func updateScoreLabel() {
        scoreLabel.text = "Score: \(game.scoreBoard.score)"
    }
    
    private func udateNumberOfSetsOnBoardLabel() {
        numberOfSetsOnBoardLabel.text = "Mogelijke sets: \(game.numberOfSetsOnBoard)"
    }
}
