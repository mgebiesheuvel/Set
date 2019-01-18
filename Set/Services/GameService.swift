//
//  GameService.swift
//  Set
//
//  Created by Marten Biesheuvel on 29/11/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import Foundation

struct GameService {
    // MARK: properties
    private let fileName = "game.json"
    private let directory = Storage.Directory.documents
    
    
    // MARK: public interface
    func getGame() -> SavedGame? {
        guard Storage.fileExists(fileName, in: directory) else {
            print("File \(fileName) in directory \(directory) does not exists.")
            return nil
        }
        
        return Storage.retrieve(fileName, from: directory, as: SavedGame.self)
    }
    
    func store(game: SavedGame) {
        Storage.store(game, to: directory, as: fileName)
    }
    
    func clear() {
        Storage.remove(fileName, from: directory)
    }
}
