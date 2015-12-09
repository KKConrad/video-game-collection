//
//  AddItemViewController.swift
//  game-collection
//
//  Created by Krizia Conrad on 12/8/15.
//  Copyright © 2015 Krizia Conrad. All rights reserved.
//

import Foundation
import UIKit


class AddItemViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var gameCollection: GameCollection!
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var gameTitleField: UITextField!
    @IBOutlet weak var genreField: UITextField!
    @IBOutlet weak var notesField: UITextField!
    
    @IBAction func save(sender: AnyObject) {
        if let gameName = gameTitleField.text, let genre = genreField.text, let notes = notesField.text {
            let game = GameItem(name: gameName, genre: genre, notes: notes)
            let selectedRow = pickerView.selectedRowInComponent(0)
            let system = gameCollection.sortedSystems()[selectedRow]
            gameCollection.addGame(game, system: system)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //This is the picker view
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gameCollection.sortedSystems().count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gameCollection.sortedSystems()[row]
    }
    
}