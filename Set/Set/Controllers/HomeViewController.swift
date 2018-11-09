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
        scoreTabelView.backgroundColor = #colorLiteral(red: 0.04486183464, green: 0.6285493338, blue: 0.09394457164, alpha: 1)
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
}
