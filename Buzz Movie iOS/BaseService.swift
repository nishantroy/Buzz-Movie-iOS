//
//  BaseService.swift
//  Buzz Movie iOS
//
//  Created by localadmin on 4/10/16.
//  Copyright © 2016 2b||!2b. All rights reserved.
//

import Foundation
import UIKit
import Firebase



//MARK: Properties

let BASE_REF = Firebase(url: "https://buzzmovieios.firebaseio.com/")


//Get current user from Firebase
let userId = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
var currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath(userId)


var currentUserName = currentUser.childByAppendingPath("Name")

var currentUserMovies = currentUser.childByAppendingPath("Movies")

var currentUserEmail = String()

func modifyRef(userId: String) {
    currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath(userId)
    currentUserName = currentUser.childByAppendingPath("Name")
    currentUserMovies = currentUser.childByAppendingPath("Movies")
}

//Firebase.defaultConfig().persistenceEnabled = true




