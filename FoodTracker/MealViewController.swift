//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Boyi Ma on 2020-12-19.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate { // for navigation responsibilities
    
    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // this value is either passed by 'MealTableViewController' in 'prepare(for:sender:)' or constructed as part of adding a new meal
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field's user input through delegate callbacks.
        nameTextField.delegate = self // Set delegate to the view controller itself.
        
        // set up views if editing an existing Meal.
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        // enable the save button only if the text field has a valid Meal name
        updateSaveButtonState()
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        nameTextField.resignFirstResponder()
        return true // tell system to process the return key press
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // disable the save button while editing
        saveButton.isEnabled = false
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // try to downcast the dictionary item to optional UIImage type
        // “Try to access dictionary item as an UIImage. If this is successful, set a new temporary constant called selectedImage to the value stored in the returned optional UIImage.”
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image
        photoImageView.image = selectedImage
        
        // Dismiss the picker
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        // depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways
        let isPresentingInAddMealMode = presentingViewController is UINavigationController // is returns a boolean indicating whether type is NavigationController
        
        if isPresentingInAddMealMode {
            // press cancel button should dismiss the add meal scene and go back to previous scene
            dismiss(animated: true, completion: nil)
        }
        else if let ownNavigationController = navigationController {
            // get the underlying navigation controller the scene was pushed on top of and pop it off
            ownNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
        
    }
    
    // this method lets you configure a view controller before it's presented
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // good habit to call super when overriding
        super.prepare(for: segue, sender: sender)
        
        // configure the destination view controller only when the save button is pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? "" // return text if not nil, and return "" when text is nil
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        // set the meal to be passed to MealTableViewController if save is pressed
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // If user taps image while typing in the text field, hide keyboard properrly.
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure the ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        // Present the image picker.
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    // MARK: Private Methods
    
    private func updateSaveButtonState() {
        // disable the save button if the text field is empty
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}

