//
//  ScoreService.swift
//  Set
//
//  Created by Marten Biesheuvel on 08/11/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import Foundation

struct ScoreService {
    // MARK: properties
    private let fileName = "score.json"
    private let directory = Storage.Directory.documents
    
    
    // MARK: public interface
    func getAllScores() -> [Score] {
        guard Storage.fileExists(fileName, in: directory) else {
            print("File \(fileName) in directory \(directory) does not exists.")
            return []
        }
        
        return Storage.retrieve(fileName, from: directory, as: [Score].self)
    }
    
    func store(score: Score) {
        var scores = getAllScores()
        scores.append(score)
        Storage.store(scores.sorted(by: { $0.score > $1.score }), to: directory, as: fileName)
    }
    
    func remove(at index: Int) {
        var scores = getAllScores()
        scores.remove(at: index)
        Storage.store(scores.sorted(by: { $0.score > $1.score }), to: directory, as: fileName)
    }
    
}
