//
//  LoginViewController.swift
//  Buzz Movie iOS
//
//  Created by localadmin on 4/10/16.
//  Copyright © 2016 2b||!2b. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import Toast_Swift


class LoginViewController: UIViewController, UITextFieldDelegate {
    //MARK: Properties
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var logoutButton: UIButton!
    
    var userName = "user"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutButton.hidden = true
        
        email.delegate = self
        password.delegate = self
//        self.navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil  && currentUser.authData != nil
        {
            self.logoutButton.hidden = false
        }
    }
    
    
    
    //MARK: Actions
    @IBAction func loginAction(sender: UIButton) {
        let email = self.email.text
        let password = self.password.text
        
        if (email != "" && password != "") { //check that password and email are entered
            BASE_REF.authUser(email, password: password, withCompletionBlock: { (error, authData) -> Void in
                if (error != nil) { //check if login was successful
                    if let errorCode = FAuthenticationError(rawValue: error.code) {
                        switch (errorCode) {
                        case .UserDoesNotExist:
                            let alert = UIAlertController(title: "Error", message: "This user does not exist", preferredStyle: .Alert)
                            
                            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
                            
                            alert.addAction(action)
                            
                            self.presentViewController(alert, animated: true, completion: nil)
                            
                        case .InvalidEmail:
                            let alert = UIAlertController(title: "Error", message: "Invalid email", preferredStyle: .Alert)
                            
                            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
                            
                            alert.addAction(action)
                            
                            self.presentViewController(alert, animated: true, completion: nil)
                            
//                            self.view.makeToastActivity(.Bottom)
                            
                        case .InvalidPassword:
                            let alert = UIAlertController(title: "Error", message: "Incorrect password", preferredStyle: .Alert)
                            
                            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
                            
                            alert.addAction(action)
                            
                            self.presentViewController(alert, animated: true, completion: nil)
                            
                        default:
                            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
                            
                            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
                            
                            alert.addAction(action)
                            
                            self.presentViewController(alert, animated: true, completion: nil)
                        }
                        self.view.hideToastActivity()
                    }
                } else {
                    self.view.makeToastActivity(.Center)
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    
                    print ("Logged in :)")
                    
                    self.view.window!.makeToast("Logged in " + email! + " successfully", duration: 3.0, position: .Bottom)
                    
                    self.performSegueWithIdentifier("loggedIn", sender: nil)
                    self.logoutButton.hidden = false
                    self.view.hideToastActivity()
                }
            })
        } else { //otherwise, return error and show alert
            let alert = UIAlertController(title: "Error", message: "Enter Email and Password", preferredStyle: .Alert)
            
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alert.addAction(action)
            
            self.presentViewController(alert, animated: true, completion: nil)
            self.view.hideToastActivity()
        }
        
    }
    
    
    @IBAction func logoutAction(sender: UIButton) {
        currentUser.unauth()
        
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
        self.logoutButton.hidden = true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
