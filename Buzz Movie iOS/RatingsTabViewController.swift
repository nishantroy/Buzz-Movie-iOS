//
//  RatingsTabViewController.swift
//  Buzz Movie iOS
//
//  Created by localadmin on 4/14/16.
//  Copyright © 2016 2b||!2b. All rights reserved.
//


import Foundation
import UIKit
import Firebase
import SwiftyJSON

class RatingsTabViewController: UITableViewController {
    var myArray = [Movie]()
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Array count returned now")
        return myArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("Setup cells now")
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieTableViewCell", forIndexPath: indexPath) as! MealTableViewCell
        cell.nameLabel.text = myArray[indexPath.item].name
        cell.movieImage.image = myArray[indexPath.item].image
        cell.ratingControl.rating = myArray[indexPath.item].rating
        return cell
    }
    
    
    
    override func viewDidLoad() {
        print("View loaded now")
        loadMovies()
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        print("View appeared now")
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    
    
        func loadMovies() {
            print("Loading movies now")
            currentUserMovies.observeEventType(.Value) { (snapshot: FDataSnapshot!) in
                let json = JSON(snapshot.value)
                print(json)
                for (key, subJson) in json {
                    let name = key
                    let userrating = subJson["User Rating"].int!
                    let imagePath = subJson["Image"].string!
                    var image = UIImage()
                    if let url = NSURL(string: imagePath) {
                        if let data = NSData(contentsOfURL: url) {
                            image = UIImage(data: data)!
                        }
                    }
                    let movie = Movie(name: name, rating: userrating, image: image)
                    self.myArray.append(movie!)
                }
            }
        }
    
}
