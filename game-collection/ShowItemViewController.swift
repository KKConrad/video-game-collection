//
//  ShowItemViewController.swift
//  game-collection
//
//  Created by Krizia Conrad on 12/8/15.
//  Copyright © 2015 Krizia Conrad. All rights reserved.
//

import UIKit

class ShowItemViewController: UIViewController {
    
    var game: GameItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        displayGameTitle.text = game.name
        displayGenre.text = game.genre
        displayNotes.text = game.notes
        displayPhoto.image = game.photo
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var displayGameTitle: UILabel!
    
    @IBOutlet weak var displayGenre: UILabel!

    @IBOutlet weak var displayNotes: UITextView!
    
    @IBOutlet weak var displayPhoto: UIImageView!
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
