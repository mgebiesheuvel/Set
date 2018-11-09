//
//  ScoreTableViewCell.swift
//  Set
//
//  Created by Marten Biesheuvel on 08/11/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var amountOfSetsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func initCell(score: Score) {
        self.scoreLabel.text = String(score.score)
        self.amountOfSetsLabel.text = String(score.amountOfSets)
        self.dateLabel.text = score.date
    }
}
