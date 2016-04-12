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


class SearchTabViewController: UIViewController {
    
    //MARK: Properties

    @IBOutlet weak var movieSearchField: UITextField!
    
    var url1 = "http://www.omdbapi.com/?t="
    var url2 = "&y=&plot=short&r=json"
    var jsonArray:JSON = []
    
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func movieSearch(sender: UIButton) {
        let movieName = self.movieSearchField.text //get user entry
        let movieURL = movieName?.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLPathAllowedCharacterSet()) //remove spaces and urlencode
        let urlPath = url1 + movieURL! + url2 //build url path
        //get request with Alamofire to oMDB and make JSON with AlamoFire
        Alamofire.request(.GET, urlPath).responseJSON { response in
            self.jsonArray = JSON(response.result.value!)
            print(self.jsonArray)
        }
    }
    
}
