//
//  ViewController.swift
//  game-collection
//
//  Created by Krizia Conrad on 11/19/15.
//  Copyright © 2015 Krizia Conrad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var gameCollection = GameCollection()
    
    @IBOutlet weak var tableView: UITableView!
    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let system = gameCollection.sortedSystems()[indexPath.section]
            var games = gameCollection.games[system]!
            let game = games[indexPath.row]
            gameCollection.games[system]!.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            saveGames()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return gameCollection.sortedSystems().count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedGames = loadGames() {
            for (index, game) in savedGames.enumerate() {
                gameCollection.addGame(game, system: game.system)
            }
        } else {
            gameCollection.addGame(GameItem(name: "Final Fantasy", genre: "RPG", notes: "Fun game to play", system: "Nintendo", photo: nil), system: "Nintendo")
            gameCollection.addGame(GameItem(name: "Kirby Superstar", genre: "Platforming Action", notes: "Allows a second player", system: "Super Nintendo", photo: nil), system: "Super Nintendo")
            gameCollection.addGame(GameItem(name: "Sonic The Hedgehog", genre: "Action", notes: "Worst Sonic even though it was the first of it's kind", system: "Sega Genesis", photo: nil), system: "Sega Genesis")
            gameCollection.addGame(GameItem(name: "Goldeneye 007", genre: "First Person Shooter", notes: "Paintball mode", system: "Nintendo 64", photo: nil), system: "Nintendo 64")
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let system = gameCollection.sortedSystems()[section]
        let games = gameCollection.games[system]!
        return games.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return gameCollection.sortedSystems()[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let system = gameCollection.sortedSystems()[indexPath.section]
        let games = gameCollection.games[system]!
        let game = games[indexPath.row]
        
        //want system to be the largest letters, game to have smaller letters, genre to have smallest letters
        cell.textLabel?.text = game.name
        cell.detailTextLabel?.text = "Genre: \(game.genre)"
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let controller = segue.destinationViewController as? AddItemViewController {
            controller.gameCollection = self.gameCollection
        }
        if let controller = segue.destinationViewController as? ShowItemViewController {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPathForCell(cell)
                let system = gameCollection.sortedSystems()[indexPath!.section]
                let games = gameCollection.games[system]!
                let game = games[indexPath!.row]
                controller.game = game
                controller.gameCollection = gameCollection
                controller.indexPath = indexPath
                
            }
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func add(sender: AnyObject) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
        }
        alertController.addAction(cancelAction)
        
        let addSystem = UIAlertAction(title: "Add System/Platform", style: .Default) { (action) in
            if let controller = self.storyboard?.instantiateViewControllerWithIdentifier("newSystem") as? NewSystemViewController {
                controller.gameCollection = self.gameCollection
                self.presentViewController(controller, animated: true, completion: nil)
            }
        }
        alertController.addAction(addSystem)
        
        let addGameItemAction = UIAlertAction(title: "Add Video Game", style: .Default) { (action) in
            self.performSegueWithIdentifier("showGameItem", sender: self)
        }
        alertController.addAction(addGameItemAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    // MARK: NSCoding
    // saving games for the persisted list
    func saveGames() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(gameCollection.gameList(), toFile: GameItem.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save games")
        }
    }
    
    // loading games from persisted list
    func loadGames() -> [GameItem]? {
        // pulling out of storage
        return NSKeyedUnarchiver.unarchiveObjectWithFile(GameItem.ArchiveURL.path!) as? [GameItem]
    }
}

