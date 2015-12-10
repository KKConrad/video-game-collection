//
//  GameItem.swift
//  game-collection
//
//  Created by Krizia Conrad on 12/7/15.
//  Copyright © 2015 Krizia Conrad. All rights reserved.
//

import Foundation
import UIKit

class GameItem: NSObject, NSCoding {
    // MARK: Properties
    var name: String
    var genre: String
    var notes: String
    var system: String
    var photo: UIImage?
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("gameItems")
    
    // MARK: Initialization
    init(name: String, genre: String, notes: String, system: String, photo: UIImage?) {
        self.name = name
        self.genre = genre
        self.notes = notes
        self.system = system
        self.photo = photo
        super.init()
    }
    
    struct PropertyKey {
        static let nameKey = "name"
        static let genreKey = "genre"
        static let notesKey = "notes"
        static let systemKey = "system"
        static let photoKey = "photo"
    }
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(genre, forKey: PropertyKey.genreKey)
        aCoder.encodeObject(notes, forKey: PropertyKey.notesKey)
        aCoder.encodeObject(system, forKey: PropertyKey.systemKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let genre = aDecoder.decodeObjectForKey(PropertyKey.genreKey) as! String
        let notes = aDecoder.decodeObjectForKey(PropertyKey.notesKey) as! String
        let system = aDecoder.decodeObjectForKey(PropertyKey.systemKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as! UIImage?
        self.init(name: name, genre: genre, notes: notes, system: system, photo: photo)
    }
}

