//
//  MealTableViewController.swift
//  Buzz Movie iOS
//
//  Created by localadmin on 4/3/16.
//  Copyright © 2016 2b||!2b. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        
        if let savedMovies = loadMovies() {
            movies += savedMovies
        } else {
            loadSampleMovies()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    func loadSampleMovies() {
        let photo1 = UIImage(named: "dawnOfJustice")!
        let movie1 = Movie(name: "Batman v Superman", rating: 2, image: photo1)
        
        let photo2 = UIImage(named: "deadpool")
        let movie2 = Movie(name: "Deadpool", rating: 4, image: photo2)
        
        let photo3 = UIImage(named: "silence")
        let movie3 = Movie(name: "Silence of the Lambs", rating: 5, image: photo3)
        
        movies += [movie1!, movie2!, movie3!]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        
        // fetch appropriate movie
        
        let movie = movies[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MovieTableViewCell
        
        cell.nameLabel.text = movie.name
        cell.photoImageView.image = movie.image
        cell.ratingControl.rating = movie.rating
        
        return cell
    }
    
    @IBAction func unwindToMovieList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? MovieViewController, movie = sourceViewController.movie {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                //Update existing movie
                movies[selectedIndexPath.row] = movie
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                let newIndexPath = NSIndexPath(forRow: movies.count, inSection: 0)
                movies.append(movie)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            saveMovies()
        }
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            movies.removeAtIndex(indexPath.row)
            saveMovies()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let movieDetailViewController = segue.destinationViewController as! MovieViewController
            // Get the cell that generated this segue.
            if let selectedMovieCell = sender as? MovieTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedMovieCell)!
                let selectedMovie = movies[indexPath.row]
                movieDetailViewController.movie = selectedMovie
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new meal")
        }
    }
    
    //MARK: NSCoding
    
    func saveMovies() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(movies, toFile: Movie.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Failed to save movies")
        }
    }
    
    func loadMovies() -> [Movie]?  {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Movie.ArchiveURL.path!) as? [Movie]
    }
    
    
}
