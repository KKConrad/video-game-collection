//
//  EditItemViewController.swift
//  game-collection
//
//  Created by Krizia Conrad on 12/9/15.
//  Copyright © 2015 Krizia Conrad. All rights reserved.
//

import UIKit

class EditItemViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var game: GameItem!
    var gameCollection: GameCollection!
    var indexPath: NSIndexPath!
    
    @IBOutlet weak var editTitle: UITextField!
    @IBOutlet weak var editGenre: UITextField!
    @IBOutlet weak var editNotes: UITextField!
    @IBOutlet weak var editSystem: UIPickerView!
    @IBOutlet weak var editPhoto: UIImageView!
    
    @IBAction func save(sender: AnyObject) {
        if let gameName = editTitle.text, let genre = editGenre.text, let notes = editNotes.text, let photo = editPhoto.image {
            let system = gameCollection.sortedSystems()[indexPath!.section]
            let games = gameCollection.games[system]!
//            let game = games[indexPath!.row]
            gameCollection.games[system]![indexPath!.row].name = gameName
            gameCollection.games[system]![indexPath!.row].genre = genre
            gameCollection.games[system]![indexPath!.row].notes = notes
            gameCollection.games[system]![indexPath!.row].photo = photo
            
//            let selectedRow = pickerView.selectedRowInComponent(0)
//            let system = gameCollection.sortedSystems()[selectedRow]
//            let game = GameItem(name: gameName, genre: genre, notes: notes, system: system, photo: photoImageView.image)
//            
//            gameCollection.addGame(game, system: system)
       // calling saveGame function right after user wants to save a game
            saveGames()
        }
        performSegueWithIdentifier("redirectToGameList", sender: sender)
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
        editPhoto.image = selectedImage
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTitle.text = game.name
        editGenre.text = game.genre
        editNotes.text = game.notes
        editPhoto.image = game.photo
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
