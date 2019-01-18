//
//  ScoreService.swift
//  Set
//
//  Created by Marten Biesheuvel on 08/11/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import Foundation
import Disk

struct ScoreService {
    // MARK: properties
    private let fileName = "score.json"
    private let directory = Disk.Directory.documents
    
    
    // MARK: public interface
    func getAllScores() -> [Score] {
        guard Disk.exists(fileName, in: directory) else {
            print("File \(fileName) in directory \(directory) does not exists.")
            return [Score]()
        }
        
        do {
            return try Disk.retrieve(fileName, from: directory, as: [Score].self)
        } catch {
            print("An error occured while fetching scores from disk: \(error)")
        }
        
        return [Score]()
    }
    
    func store(score: Score) {
        var scores = getAllScores()
        scores.append(score)
        
        do {
            try Disk.save(scores.sorted(by: { $0.score > $1.score }), to: directory, as: fileName)
        } catch {
            print("An error occured while saving a score to disk: \(error)")
        }
    }
    
    func remove(at index: Int) {
        var scores = getAllScores()
        scores.remove(at: index)
        
        do {
            try Disk.save(scores.sorted(by: { $0.score > $1.score }), to: directory, as: fileName)
        } catch {
            print("An error occured while removing a score from disk: \(error)")
        }
    }
}
