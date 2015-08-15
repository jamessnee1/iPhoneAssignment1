//
//  movieTableViewController.swift
//  SwiftAssignment1
//
//  Created by James Snee on 13/03/2015.
//  Copyright (c) 2015 James Snee and Heather Ingram. All rights reserved.
//

import UIKit
import AVFoundation

//this table view was created by following: http://www.raywenderlich.com/16873/how-to-add-search-into-a-table-view
class movieTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    

    //Create an array of movie structs. This will hold all of them
    var movies = [Movie]()
    let frozen = UIImage(named: "frozen.jpg")
    let startrek = UIImage(named: "startrek.jpg")
    let starwars = UIImage(named: "starwars.jpg")
    let terminator = UIImage(named: "terminator.jpg")
    let toystory = UIImage(named: "toystory.jpg")
    
    //sound for buttons
    var click = AVAudioPlayer()
    
    //If user decides to use the search bar, we can filter the movies to this
    var filteredMovies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //sound URL
        var clickSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("click", ofType: "aif")!)
        click = AVAudioPlayer(contentsOfURL:clickSound, error: nil)

        
        //create sample data for movies
        self.movies = [
            Movie(movieName: "Star Trek: Into Darkness", movieRating: "M", movieImage: startrek!, movieDesc: "After the crew of the Enterprise find an unstoppable force of terror from within their own organization, Captain Kirk leads a manhunt to a war-zone world to capture a one-man weapon of mass destruction.",
                timeOfMovie: [
                    MovieTime(playingAtCinema: "Chadstone", time: ["9:30am-11:30am"]),
                    MovieTime(playingAtCinema: "Melbourne Central", time: ["3:30pm-5:30pm"]),
                    MovieTime(playingAtCinema: "Doncaster", time: ["2:50pm-4:50pm"])
                ]),
            
            Movie(movieName: "Star Wars Episode V: The Empire Strikes Back", movieRating: "PG",movieImage: starwars!, movieDesc: "After the rebels have been brutally overpowered by the Empire on their newly established base, Luke Skywalker takes advanced Jedi training with Master Yoda, while his friends are pursued by Darth Vader as part of his plan to capture Luke.",
                timeOfMovie: [
                    MovieTime(playingAtCinema: "Knox", time: ["10:30am-12:30pm"]),
                    MovieTime(playingAtCinema: "Chadstone", time: ["12:30pm-2:30pm"]),
                    MovieTime(playingAtCinema: "Werribee", time: ["10:30am-12:30pm"])
                ]),
            
            Movie(movieName: "Frozen", movieRating: "PG",movieImage: frozen!, movieDesc: "When the newly crowned Queen Elsa accidentally uses her power to turn things into ice to curse her home in infinite winter, her sister, Anna, teams up with a mountain man, his playful reindeer, and a snowman to change the weather condition.",
                timeOfMovie: [
                    MovieTime(playingAtCinema: "Melbourne Central", time: ["3:30pm-5:30pm"]),
                    MovieTime(playingAtCinema: "Dandenong", time: ["1:30pm-3:30pm"]),
                    MovieTime(playingAtCinema: "Box Hill", time: ["12:30pm-2:30pm"])
                
                ]),
            
            Movie(movieName: "Toy Story", movieRating: "G", movieImage: toystory!, movieDesc: "Imagination runs rampant when toys become mobile when not watched. Two toys, Woody and Buzz Lightyear despise each other like no other. But, when the toys are separated from their home, a truce is formed between them all in an effort to journey home.",
                timeOfMovie: [
                    MovieTime(playingAtCinema: "Selby", time: ["2:30am-4:30am"]),
                    MovieTime(playingAtCinema: "Melbourne Central", time: ["9:30am-11:30am"]),
                    MovieTime(playingAtCinema: "Doncaster", time: ["6:50pm-8:50pm"])
                ]),
            
            Movie(movieName: "The Terminator", movieRating: "R", movieImage: terminator!, movieDesc: "A cyborg is sent from the future on a deadly mission. He has to kill Sarah Connor, a young woman whose life will have a great significance in years to come. Sarah has only one protector - Kyle Reese - also sent from the future. The Terminator uses his exceptional intelligence and strength to find Sarah, but is there any way to stop the seemingly indestructible cyborg?",
                timeOfMovie: [
                    MovieTime(playingAtCinema: "Frankston", time: ["6:30pm-8:30pm"]),
                    MovieTime(playingAtCinema: "Dandenong", time: ["1:30pm-3:30pm"]),
                    MovieTime(playingAtCinema: "Werribee", time: ["9:30pm-11:30pm"])
                
                ])
            ]
        
        //reload table view
        self.tableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //returns the number of elements in the tableview if filtered or unfiltered
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.filteredMovies.count
        }else {
            return self.movies.count
        }
        
        
    }
    
    //when user selects an item in tableview, perform segue
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("moviesDetail", sender: tableView)
    }
    
    //segue to the next view controller, pushing all the information to it
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "moviesDetail" {
            
            
            let movieDetails = segue.destinationViewController as! MovieDetailViewController
            
            //if using the search bar
            if sender as! UITableView == self.searchDisplayController!.searchResultsTableView {
                
                let indexPath = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow()!
                let destinationTitle = self.filteredMovies[indexPath.row].movieName
                let destinationDesc = self.filteredMovies[indexPath.row].movieDesc
                let destinationImage = self.filteredMovies[indexPath.row].movieImage
                let destinationRating = "Rating: \(self.filteredMovies[indexPath.row].movieRating)"
                let destinationCinemaAndTimes = self.filteredMovies[indexPath.row].timeOfMovie
                movieDetails.title = destinationTitle
                movieDetails.movieDescText = destinationDesc
                movieDetails.poster = destinationImage
                movieDetails.movieRatingText = destinationRating
                movieDetails.cinemaTimes = destinationCinemaAndTimes
                
                //play sound
                click.prepareToPlay()
                click.play()
               
                
            
            }
            //if not using the search bar
            else {

                let indexPath = self.tableView.indexPathForSelectedRow()!
                let destinationTitle = self.movies[indexPath.row].movieName
                let destinationDesc = self.movies[indexPath.row].movieDesc
                let destinationImage = self.movies[indexPath.row].movieImage
                let destinationRating = "Rating: \(self.movies[indexPath.row].movieRating)"
                let destinationCinemaAndTimes = self.movies[indexPath.row].timeOfMovie
                movieDetails.title = destinationTitle
                movieDetails.movieDescText = destinationDesc
                movieDetails.poster = destinationImage
                movieDetails.movieRatingText = destinationRating
                movieDetails.cinemaTimes = destinationCinemaAndTimes
                
                //play sound
                click.prepareToPlay()
                click.play()
                
            
            }

        }
        
    }
    //back button
    @IBAction func backButton(sender: AnyObject) {
        
        click.prepareToPlay()
        click.play()
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    //function to populate cells of the TableView
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        var movie : Movie
        //check to see if normal table or search results table is used, and set the object from the appropriate array.
        if tableView == self.searchDisplayController!.searchResultsTableView {
            movie = filteredMovies[indexPath.row]
            
        }else {
            // get the data from movies
            movie = movies[indexPath.row]
        }
        
        //configure cell with name, and picture
        cell.textLabel!.text = movie.movieName
        cell.imageView?.image = movie.movieImage
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator

        return cell
    }
    
    //helper method for filtering
    func filterContentForSearchText(searchText : String, scope: String = "All"){
        
        self.filteredMovies = self.movies.filter({ (movie: Movie) -> Bool in
            
            let categoryMatch  = (scope == "All") || (movie.movieRating == scope)
            let stringMatch = movie.movieName.rangeOfString(searchText)
            return categoryMatch && (stringMatch != nil)
        
        })

    }
    
    //search display controller method for search string
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    //search display controller method for scope
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
        return true
    }

    
}
