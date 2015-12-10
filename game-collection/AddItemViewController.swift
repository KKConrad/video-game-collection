//
//  AddItemViewController.swift
//  game-collection
//
//  Created by Krizia Conrad on 12/8/15.
//  Copyright © 2015 Krizia Conrad. All rights reserved.
//

import Foundation
import UIKit


class AddItemViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var gameCollection: GameCollection!
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var gameTitleField: UITextField!
    @IBOutlet weak var genreField: UITextField!
    @IBOutlet weak var notesField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBAction func save(sender: AnyObject) {
        if let gameName = gameTitleField.text, let genre = genreField.text, let notes = notesField.text {
            let selectedRow = pickerView.selectedRowInComponent(0)
            let system = gameCollection.sortedSystems()[selectedRow]
            let game = GameItem(name: gameName, genre: genre, notes: notes, system: system, photo: photoImageView.image)

            gameCollection.addGame(game, system: system)
            //calling saveGame function right after user wants to save a game
            saveGames()
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
    

    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken (doing camera for now.)
        imagePickerController.sourceType = .Camera
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        //This method asks ViewController to present the view controller defined by imagePickerController
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image and this uses the original
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image. 
        photoImageView.image = selectedImage
        
        // Dismiss the picker. 
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: NSCoding
    // saving games for the persisted list
    func saveGames() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(gameCollection.gameList(), toFile: GameItem.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save games")
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
}