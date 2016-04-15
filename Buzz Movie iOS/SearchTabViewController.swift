//
//  SearchTabViewController.swift
//  Buzz Movie iOS
//
//  Created by localadmin on 4/11/16.
//  Copyright © 2016 2b||!2b. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift


class SearchTabViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var movieSearchField: UITextField!
    
    var url1 = "http://www.omdbapi.com/?t="
    var url2 = "&y=&plot=short&r=json"
    var jsonArray = [[String:AnyObject]]()
    
    var moviePlot = String()
    var movieRating = String()
    var movieName = String()
    var moviePicturePath = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
        if (segue.identifier == "showSearchResult")
        {
            let destinationViewController = segue.destinationViewController as? UINavigationController
            if let targetController = destinationViewController?.topViewController as? DisplayMovieViewController {
                targetController.plot = self.moviePlot
                targetController.imdbRating = self.movieRating
                targetController.name = self.movieName
                targetController.imagePath = self.moviePicturePath
                
            }
        }
        
    }
    
    
    
    @IBAction func movieSearch(sender: UIButton) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let movieName = self.movieSearchField.text //get user entry
        let movieURL = movieName?.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLPathAllowedCharacterSet()) //remove spaces and urlencode
        let urlPath = url1 + movieURL! + url2 //build url path
        //get request with Alamofire to oMDB and make JSON with AlamoFire
        Alamofire.request(.GET, urlPath).responseJSON { response in
            //            if (response.response == "True") {
            if (JSON(response.result.value!)["Response"] != "False") {
                let jsonVar = JSON(response.result.value!)
                
                if let plot = jsonVar["Plot"].string {
                    self.moviePlot = plot
                }
                
                if let rating = jsonVar["imdbRating"].string {
                    self.movieRating = rating
                }
                
                if let name = jsonVar["Title"].string {
                    self.movieName = name
                    print(name)
                }
                
                if let picpath = jsonVar["Poster"].string {
                    self.moviePicturePath = picpath
                }
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                self.performSegueWithIdentifier("showSearchResult", sender: nil)
            } else {
                self.view.window?.makeToast("Movie could not be found! Try typing the full name", duration: 2.0, position: .Bottom)
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
            
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}


