//
//  CreateAccountViewController.swift
//  Buzz Movie iOS
//
//  Created by localadmin on 4/10/16.
//  Copyright © 2016 2b||!2b. All rights reserved.
//

import UIKit
import Foundation
//import Firebase

class CreateAccountViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    //MARK: Actions
    @IBAction func createAccountAction(sender: UIButton) {
        let email = self.emailTextField.text
        
        let password = self.passwordTextField.text
        
        if (email != "" && password != "") {
            
            BASE_REF.createUser(email, password: password, withValueCompletionBlock: { (error, result) -> Void in
        
                if (error == nil) {
                    BASE_REF.authUser(email, password: password, withCompletionBlock: { (error, authData) -> Void in
                        if (error == nil) {
                            NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                            
                            print("Account created :)")
                            
                            self.dismissViewControllerAnimated(true, completion: nil)
                            
                        } else {
                            print(error)
                        }
                    })
            
                } else {
                    print(error)
                }
            })
        } else {
            let alert = UIAlertController(title: "Error", message: "Enter Email and Password", preferredStyle: .Alert)
            
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alert.addAction(action)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    @IBAction func cancelAction(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
