//
//  NewSystemViewController.swift
//  game-collection
//
//  Created by Krizia Conrad on 12/8/15.
//  Copyright © 2015 Krizia Conrad. All rights reserved.
//

import UIKit

class NewSystemViewController: UIViewController {
    
    @IBOutlet weak var newSystemField: UITextField!
    var gameCollection: GameCollection!
    
    
    @IBAction func save() {
        if let systemName = newSystemField.text where !systemName.isEmpty {
            gameCollection.addSystem(systemName)
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}