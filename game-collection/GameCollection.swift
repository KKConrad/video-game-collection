//
//  GameCollection.swift
//  game-collection
//
//  Created by Krizia Conrad on 12/7/15.
//  Copyright © 2015 Krizia Conrad. All rights reserved.
//

import Foundation

class GameCollection: CustomStringConvertible {
    var games = [String: [GameItem]]()
    
    func addSystem(system: String) {
        if !games.keys.contains(system) {
            games[system] = [GameItem]()
        }
    }
    
    func addGame(game: GameItem, system: String) {
        var gamesForSystem = games[system]
        if gamesForSystem == nil {
            gamesForSystem = [GameItem]()
        }
        gamesForSystem?.append(game)
        games[system] = gamesForSystem
    }
    
    
    func sortedList(system: String) -> [GameItem] {
        guard let gamesForSystem = games[system] else {
            return [GameItem]()
        }
        return gamesForSystem.sort({ $0.name.compare($1.name) == .OrderedAscending })
    }
    
    func sortedSystems() -> [String] {
        return games.keys.sort()
    }
    
    var description: String {
        return "The Game Collection"
    }
    
}