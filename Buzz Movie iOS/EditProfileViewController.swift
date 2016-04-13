//
//  EditProfileViewController.swift
//  Buzz Movie iOS
//
//  Created by localadmin on 4/12/16.
//  Copyright © 2016 2b||!2b. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    var userName = String()
    var userMajor = String()
    var userEmail = String()
    var emailChanged = false
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userMajorTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userPasswordTextField.hidden = true
        self.passwordLabel.hidden = true
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        //Do something
        loadUserData()
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
    
    //MARK: Actions
    
    @IBAction func saveUserChanges(sender: AnyObject) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        if (userNameTextField.text! == "" || userMajorTextField.text! == "" || userEmailTextField.text! == "") {
            self.view.window!.makeToast("Name, Major or Email cannot be empty! Please try again", duration: 1.0, position: .Center)
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        } else {
            let userData = ["Name": userNameTextField.text!, "Major": userMajorTextField.text!, "Email": userEmailTextField.text!]
            if (emailChanged) {
                BASE_REF.changeEmailForUser(currentUserEmail, password: userPasswordTextField.text!, toNewEmail: userEmailTextField.text!, withCompletionBlock: { error in
                    if error != nil {
                        self.view.window!.makeToast(error.localizedDescription, duration: 1.5, position: .Center)
                        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    } else {
                        currentUser.setValue(userData)
                        self.view.window!.makeToast("Profile updated", duration: 1.0, position: .Bottom)
                        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    
                })
            } else {
                currentUser.setValue(userData)
                self.view.window!.makeToast("Profile updated", duration: 1.0, position: .Bottom)
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            
        }
    }
    
    @IBAction func cancelChanges(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    func loadUserData() {
        self.userNameTextField.text = self.userName
        self.userMajorTextField.text = self.userMajor
        self.userEmailTextField.text = self.userEmail
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func emailChanged(sender: UITextField) {
        self.userPasswordTextField.hidden = false
        self.passwordLabel.hidden = false
        self.emailChanged = true
    }
    
    @IBAction func logoutUser(sender: UIButton) {
        BASE_REF.unauth()
        currentUser.unauth()
        //add segue to loginView
        self.performSegueWithIdentifier("logoutUser", sender: nil)
    }
    
}
