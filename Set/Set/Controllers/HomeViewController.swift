//
//  ScoreTableViewController.swift
//  Set
//
//  Created by Marten Biesheuvel on 08/11/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    // MARK: properties
    private var scores = [Score]()
    
    // MARK: outlets
    @IBOutlet weak var scoreTabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initScoreTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadScoresFromStorage()
    }
    
    // MARK: private interface
    private func initScoreTableView() {
        scoreTabelView.dataSource = self
        scoreTabelView.delegate = self
        scoreTabelView.tableFooterView = UIView()
    }
    
    private func loadScoresFromStorage() {
        scores = ScoreService().getAllScores()
        scoreTabelView.reloadData()
    }
    
    // MARK: scoreTableView (UITableView)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "score-label", for: indexPath) as! ScoreTableViewCell
        cell.initCell(score: scores[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            ScoreService().remove(at: indexPath.row)
            self.scores = ScoreService().getAllScores()
            
            self.scoreTabelView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
