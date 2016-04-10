//
//  LoginViewController.swift
//  Buzz Movie iOS
//
//  Created by localadmin on 4/10/16.
//  Copyright © 2016 2b||!2b. All rights reserved.
//

import UIKit
import Foundation


class LoginViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutButton.hidden = true
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
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
                    
                    let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    
                    alert.addAction(action)
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                } else {
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    
                    print ("Logged in :)")
                    
                    self.performSegueWithIdentifier("loginSuccessful", sender: nil)
                    self.logoutButton.hidden = false
                }
            })
        } else { //otherwise, return error and show alert
            let alert = UIAlertController(title: "Error", message: "Enter Email and Password", preferredStyle: .Alert)
            
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alert.addAction(action)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func logoutAction(sender: UIButton) {
        currentUser.unauth()
        
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
        self.logoutButton.hidden = true
    }
    
}
