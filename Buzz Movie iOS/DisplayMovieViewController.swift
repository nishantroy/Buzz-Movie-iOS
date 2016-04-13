//
//  DisplayMovieViewController.swift
//  Buzz Movie iOS
//
//  Created by localadmin on 4/12/16.
//  Copyright © 2016 2b||!2b. All rights reserved.
//

import UIKit

class DisplayMovieViewController: UIViewController {
    
    //MARK: Properties
    
    var plot = String()
    var imdbRating = String()
    var name = String()
    var imagePath = String()
    var userRating = Int()
    

    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var moviePlot: UITextView!
    @IBOutlet weak var moviePicture: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    var amountOfLinesToBeShown:CGFloat = 5
    var maxHeight:CGFloat? {
        return moviePlot.font!.lineHeight * amountOfLinesToBeShown
    }
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Display Movie"

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
        self.view.window!.makeToast("You rated this movie as a \(self.userRating)", duration: 1, position: .Bottom)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}
