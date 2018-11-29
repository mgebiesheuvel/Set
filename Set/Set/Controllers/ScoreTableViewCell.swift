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
    
    func initCell(score: String, amountOfSets: String, date: String) {
        self.scoreLabel.text = "\(score) punten"
        self.amountOfSetsLabel.text = "\(amountOfSets) sets"
        self.dateLabel.text = date
    }
}
