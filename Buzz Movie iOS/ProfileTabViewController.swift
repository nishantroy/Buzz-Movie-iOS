//
//  ProfileTabViewController.swift
//  Buzz Movie iOS
//
//  Created by localadmin on 4/11/16.
//  Copyright © 2016 2b||!2b. All rights reserved.
//

import UIKit
import Firebase

class ProfileTabViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var userName = "userName"
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        loadUserData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     */
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("Preparing")
        if (segue.identifier == "editProfileSegue")
        {
            let destinationViewController = segue.destinationViewController as? UINavigationController
            if let targetController = destinationViewController?.topViewController as? EditProfileViewController {
                targetController.userName = self.nameLabel.text!
                targetController.userMajor = self.majorLabel.text!
                targetController.userEmail = self.emailLabel.text!
                
            }
        }
    }
    
    
    @IBAction func logoutUser(sender: AnyObject) {
        BASE_REF.unauth()
        currentUser.unauth()
        //add segue to loginView
        self.performSegueWithIdentifier("logoutUser", sender: nil)
    }
    
    func loadUserData() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        currentUser.observeEventType(.Value) { (snap: FDataSnapshot!) in
            if let name = snap.value["Name"] as? String{ self.nameLabel.text = name}
            if let major = snap.value["Major"] as?
                String {self.majorLabel.text = major}
            if let email = snap.value["Email"] as?
                String {
                self.emailLabel.text = email
                currentUserEmail = email
            }
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    //MARK: Actions
    
    
    @IBAction func editProfile(sender: AnyObject) {
        performSegueWithIdentifier("editProfileSegue", sender: nil)
    }
    
    
}
