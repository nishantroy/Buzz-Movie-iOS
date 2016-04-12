//
//  CreateAccountViewController.swift
//  Buzz Movie iOS
//
//  Created by localadmin on 4/10/16.
//  Copyright © 2016 2b||!2b. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class CreateAccountViewController: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var majorTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        nameTextField.delegate = self
        majorTextField.delegate = self
        
    }
    
    //MARK: Actions
    @IBAction func createAccountAction(sender: UIButton) {
        let email = self.emailTextField.text
        
        let password = self.passwordTextField.text
        
        let name = self.nameTextField.text
        
        let major = self.majorTextField.text
        
        let usersRef = BASE_REF.childByAppendingPath("users")
        
        if (email != "" && password != "" && name != "" && major != "") {
            
    
            
            BASE_REF.createUser(email, password: password, withValueCompletionBlock: { (error, result) -> Void in
        
                if (error == nil) {
                    BASE_REF.authUser(email, password: password, withCompletionBlock: { (error, authData) -> Void in
                        if (error == nil) {
                            NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                            
                            print("Account created :)")
                            
                            let userDict = ["Name": name!, "Major": major!, "Email": email!]
                            
                            let uid = authData.uid
                            
                            usersRef.childByAppendingPath(uid).setValue(userDict)
                            
                            self.dismissViewControllerAnimated(true, completion: nil)
                            
                        } else {
                            print(error)
                        }
                    })
            
                } else {
                    if let errorCode = FAuthenticationError(rawValue: error.code) {
                        switch (errorCode) {
                        case .EmailTaken:
                            let alert = UIAlertController(title: "Error", message: "Email is already taken!", preferredStyle: .Alert)
                            
                            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
                            
                            alert.addAction(action)
                            
                            self.presentViewController(alert, animated: true, completion: nil)
                            
                        default:
                            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
                            
                            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
                            
                            alert.addAction(action)
                            
                            self.presentViewController(alert, animated: true, completion: nil)
                        }
                    }
                }
            })
        } else {
            let alert = UIAlertController(title: "Error", message: "Enter email, password, name and major", preferredStyle: .Alert)
            
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alert.addAction(action)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    @IBAction func cancelAction(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
