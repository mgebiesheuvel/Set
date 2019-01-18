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
    var timer = Timer()
    
    // MARK: outlets
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var numberOfSetsOnBoardLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func touchCardButton(_ sender: UIButton) {
        impact.impactOccurred() // give haptic feedback to the app user
        guard let index = cardButtons.index(of: sender) else { return }
        game.chooseCard(atIndex: index)
        updateViewFromModel()
    }
    
    @IBAction func touchEndGameButton(_ sender: UIButton) {
        impact.impactOccurred() // give haptic feedback to the app user
        timer.invalidate()
        
        let alert = UIAlertController(title: "En nu?", message: "Je kunt toch doorgaan, stoppen en het spel opslaan of stoppen en de voortgang verwijderen.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Toch doorgaan", style: .default , handler: { (_) in
            self.startTimer()
        }))
        alert.addAction(UIAlertAction(title: "Stoppen en opslaan", style: .default , handler: { (_) in
            self.saveGame()
            self.dismiss(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Stoppen en verwijderen", style: .default , handler: { (_) in
            GameService().clear()
            self.dismiss(animated: true)
        }))
        
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        restoreGame()
        updateViewFromModel()
        startTimer()
    }
    
    // MARK: private interface
    private func updateViewFromModel() {
        saveGame()
        checkGameIsOver()
        updateCardButtonsFromModel()
        updateScoreLabel()
        udateNumberOfSetsOnBoardLabel()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: (#selector(GameViewController.updateTimeLabel)),
            userInfo: nil,
            repeats: true
        )
    }
    
    private func restoreGame() {
        guard let savedGame = GameService().getGame() else { return }
    
        self.game.deck = savedGame.deck
        self.game.board = savedGame.board
        self.game.scoreBoard.score = savedGame.score
        
        if let time = savedGame.time {
           self.game.timer.restore(time: time)
        } else {
            self.game.timer.restore(time: 0)
        }
        
        for card in self.game.board {
            card.deselect()
        }
    }
    
    private func saveGame() {
        let savedGame = SavedGame(
            deck: game.deck,
            board: game.board,
            score: game.scoreBoard.score,
            time: game.timer.runningTime
        )
        
        GameService().store(game: savedGame)
    }
    
    private func checkGameIsOver() {
        if game.numberOfSetsOnBoard == 0 && game.deck.count == 0 {
            timer.invalidate()
            ScoreService().store(
                score: Score(
                    score: self.game.scoreBoard.score,
                    amountOfSets: self.game.foundSets,
                    time: self.game.timer.runningTime,
                    date: DateTime().getCurrentDate(in: nil)
                )
            )
            GameService().clear()
            
            let alert = UIAlertController(title: "Game Over!", message: "Het spel is voorbij. Er zijn geen sets meer op het bord.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Oke!", style: .default , handler: { (_) in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true)
        }
    }
    
    private func updateCardButtonsFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index] as! CardButton
            
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
        }
    }
    
    @objc private func updateTimeLabel() {
        game.timer.updateRunningTime()
        let formattedTime = DateTime.formatTimeIntoString(game.timer.runningTime)
        timeLabel.text = "\(formattedTime)"
    }
    
    private func updateScoreLabel() {
        scoreLabel.text = "\(game.scoreBoard.score)"
    }
    
    private func udateNumberOfSetsOnBoardLabel() {
        let partOne = NSMutableAttributedString(string: "ER ZIJN ")
        let partTwo  = NSMutableAttributedString(string: "\(game.numberOfSetsOnBoard)", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        let partThree = NSMutableAttributedString(string: " MOGELIJKE COMBINATIES")
        
        let attributedLabelText = partOne
        attributedLabelText.append(partTwo)
        attributedLabelText.append(partThree)

        numberOfSetsOnBoardLabel.attributedText = attributedLabelText
    }
}
