//
//  GameService.swift
//  Set
//
//  Created by Marten Biesheuvel on 29/11/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import Foundation
import Disk

struct GameService {
    // MARK: properties
    private let fileName = "game.json"
    private let directory = Disk.Directory.documents
    
    
    // MARK: public interface
    func getGame() -> SavedGame? {
        guard Disk.exists(fileName, in: directory) else {
            print("File \(fileName) in directory \(directory) does not exists.")
            return nil
        }
        
        do {
            return try Disk.retrieve(fileName, from: directory, as: SavedGame.self)
        } catch {
            print("An error occured while fetching a saved game from disk: \(error)")
        }
        return nil
    }
    
    func store(game: SavedGame) {
        do {
            try Disk.save(game, to: directory, as: fileName)
        } catch {
            print("An error occured while saving a game to disk: \(error)")
        }
    }
    
    func clear() {
        do {
            try Disk.remove(fileName, from: directory)
        } catch {
            print("An error occured while removing a saved game from disk: \(error)")
        }
    }
}
