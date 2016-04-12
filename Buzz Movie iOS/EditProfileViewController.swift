//
//  EditProfileViewController.swift
//  Buzz Movie iOS
//
//  Created by localadmin on 4/12/16.
//  Copyright © 2016 2b||!2b. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    var userName = ""
    var userMajor = ""

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userMajorTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        let userData = ["Name": userNameTextField.text!, "Major": userMajorTextField.text!]
        currentUser.setValue(userData)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelChanges(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loadUserData() {
        self.userNameTextField.text = self.userName
        self.userMajorTextField.text = self.userMajor
    }
    

}
