//
//  MovieViewController.swift
//  Buzz Movie iOS
//
//  Created by localadmin on 4/1/16.
//  Copyright © 2016 2b||!2b. All rights reserved.
//

import UIKit


class MovieViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var ratingControl: RatingControl!
    
    
    var movie:Movie?
    

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle user input through delegate callbacks
        nameTextField.delegate = self
        
        // Set up views if editing an existing Meal.
        if let movie = movie {
            navigationItem.title = movie.name
            nameTextField.text   = movie.name
            photoImageView.image = movie.image
            ratingControl.rating = movie.rating
        }
        
        checkValidMovieName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //Hide keyboard
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        //Disable save while editing
        saveButton.enabled = false
    }
    
    func checkValidMovieName() {
        //Disable save if name not valid
        let name = nameTextField.text ?? ""
        saveButton.enabled = !name.isEmpty
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidMovieName()
        navigationItem.title = textField.text
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        //dismiss picker if user cancels
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //display selected image
        photoImageView.image = selectedImage
        
        //dismiss picker
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    //MARK: Navigation
    
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (saveButton === sender) {
            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            let rating = ratingControl.rating
            movie = Movie(name: name, rating: rating, image: photo)
        }
    }
    

    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        // Image Picker Controller lets user pick images from library
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .PhotoLibrary
        
        //Let View Controller know when user picks image
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    
    

}

