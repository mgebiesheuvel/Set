//
//  ScoreTableViewController.swift
//  Set
//
//  Created by Marten Biesheuvel on 29/11/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import UIKit

class ScoreTableViewController: UITableViewController {
    
    // MARK: properties
    private var scores = [Score]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadScoresFromStorage()
    }
    
    // MARK: private interface
    private func loadScoresFromStorage() {
        scores = ScoreService().getAllScores()
        self.tableView?.reloadData()
    }
    
    // MARK: table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.scores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let score = scores[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "score-label", for: indexPath) as! ScoreTableViewCell
        cell.initCell(score: String(score.score), amountOfSets: String(score.amountOfSets), date: String(score.date))
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ScoreService().remove(at: indexPath.row)
            self.scores = ScoreService().getAllScores()
            self.tableView?.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
