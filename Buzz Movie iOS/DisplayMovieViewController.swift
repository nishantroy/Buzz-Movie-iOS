//
//  DisplayMovieViewController.swift
//  Buzz Movie iOS
//
//  Created by localadmin on 4/12/16.
//  Copyright © 2016 2b||!2b. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class DisplayMovieViewController: UIViewController {
    
    //MARK: Properties
    
    var plot = String()
    var imdbRating = String()
    var name = String()
    var imagePath = String()
    var userRating = Int()
    var oldRating = 0
    var alreadyRated = false
    var total = 0
    var users = 0
    
    
    
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var moviePlot: UITextView!
    @IBOutlet weak var moviePicture: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var averageRating: UILabel!
    
    
    var amountOfLinesToBeShown:CGFloat = 5
    var maxHeight:CGFloat? {
        return moviePlot.font!.lineHeight * amountOfLinesToBeShown
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Display Movie"
        self.averageRating.text = "Not rated yet"
        checkIfRated(self.name)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.movieRating.text = imdbRating
        self.moviePlot.text = plot
        self.navigationItem.title = name
        moviePlot.sizeThatFits(CGSizeMake(moviePlot.frame.size.width, maxHeight!))
        
        
        if let url = NSURL(string: imagePath) {
            if let data = NSData(contentsOfURL: url) {
                moviePicture.image = UIImage(data: data)
            }
        }
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
    
    @IBAction func backToSearch(sender: UIBarButtonItem) {
        self.userRating = ratingControl.rating
        //TODO: Add child for every user in Firebase tracking which movies they've rated and how much they rated it, if rating > 0 only.
        
        if (self.userRating != self.oldRating) {
            let movie = ["User Rating": self.userRating, "Plot": self.plot, "IMDB Rating": self.imdbRating, "Image": self.imagePath]
            
            if (!alreadyRated) {
                BASE_REF.childByAppendingPath("movies").childByAppendingPath(self.name).childByAppendingPath("Users").runTransactionBlock({
                    (currentData:FMutableData!) in
                    var value = currentData.value as? Int
                    if (value == nil) {
                        value = 0
                    }
                    currentData.value = value! + 1
                    return FTransactionResult.successWithValue(currentData)
                })
                
            }
            
            
            currentUserMovies.updateChildValues([self.name: movie])
            
            BASE_REF.childByAppendingPath("movies").childByAppendingPath(self.name).childByAppendingPath("Total").runTransactionBlock({
                (currentData:FMutableData!) in
                var value = currentData.value as? Int
                if (value == nil) {
                    value = 0
                }
                currentData.value = value! + self.userRating - self.oldRating
                return FTransactionResult.successWithValue(currentData)
            })
            
            self.view.window!.makeToast("You rated this movie as a \(self.userRating)", duration: 1, position: .Bottom)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func checkIfRated(movieName: String) {
        currentUserMovies.observeEventType(.Value) { (snap: FDataSnapshot!) in
            let json = JSON(snap.value)
            if (json[self.name] != JSON.null) {
                print("Found!")
                let rating = json[self.name]["User Rating"].int!
                self.ratingControl.rating = rating
                self.oldRating = rating
                self.alreadyRated = true
            } else {
                print("Not yet rated!")
            }
        }
        
        BASE_REF.childByAppendingPath("movies").childByAppendingPath(movieName).observeEventType(.Value) {(snap: FDataSnapshot!) in
            
            if (snap.exists()) {
                print("Snapshot found!")
                if let total = snap.value["Total"] as? Int{ self.total = total}
                if let users = snap.value["Users"] as? Int{ self.users = users}
                if (self.total != 0 && self.users != 0) {
                    let avg = self.total/self.users
                    self.averageRating.text = String(avg)
                }
            }
            
        }
        
        
    }
    
    
}
