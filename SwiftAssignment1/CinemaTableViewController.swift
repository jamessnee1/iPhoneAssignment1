//
//  CinemaTableViewController.swift
//  SwiftAssignment1
//
//  Created by James Snee on 13/03/2015.
//  Copyright (c) 2015 James Snee and Heather Ingram. All rights reserved.
//

import UIKit
import AVFoundation

//this table view was created by following: http://www.raywenderlich.com/16873/how-to-add-search-into-a-table-view
class CinemaTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var click = AVAudioPlayer()
    
    //create an array of cinema structs
    var cinemas = [Cinema]()
    var movies = [Movie]()
    let frozen = UIImage(named: "frozen.jpg")
    let startrek = UIImage(named: "startrek.jpg")
    let starwars = UIImage(named: "starwars.jpg")
    let terminator = UIImage(named: "terminator.jpg")
    let toystory = UIImage(named: "toystory.jpg")
    
    
    //If user decides to use the search bar, we can filter the cinemas to this
    var filteredMovies = [Movie]()
    var filteredCinemas = [Cinema]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sound URL
        var clickSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("click", ofType: "aif")!)
        click = AVAudioPlayer(contentsOfURL:clickSound, error: nil)
        
        //create sample data for cinemas
        self.cinemas = [
            Cinema(cinemaName: "Chadstone", cinemaAddress: "10 Chadstone Shopping Centre, Chadstone VIC", cinemaDesc: "Chadstone Cinemas have the distinction\n of being the largest cinema in\n the Southern Hemisphere.", moviesPlaying: [
                "Star Trek: Into Darkness", "The Terminator", "Frozen"]),
            Cinema(cinemaName: "Melbourne Central", cinemaAddress: "Melbourne Central Shopping Centre, Melbourne VIC", cinemaDesc: "Melbourne Central Cinemas are deluxe\n cinemas, situated on Level 3 of Melbourne\n Central Shopping Centre.", moviesPlaying: ["Star Wars Episode V: The Empire Strikes Back", "Toy Story", "The Terminator"]),
            Cinema(cinemaName: "Knox", cinemaAddress: "10 Knox ave, Knox VIC", cinemaDesc: "Knox Cinemas are a little away from\n the city, but are sure to delight the most\n discerning movie-goer.", moviesPlaying: ["Frozen", "Toy Story", "The Terminator"]),
            Cinema(cinemaName: "Doncaster", cinemaAddress: "25 Doncaster Way, Doncaster VIC", cinemaDesc: "Doncaster Cinemas boast 3\n IMAX Screens, as well as\n luxury Gold Class.", moviesPlaying: ["Star Trek: Into Darkness", "Toy Story", "Star Wars Episode V: The Empire Strikes Back"]),
            Cinema(cinemaName: "Werribee", cinemaAddress: "19 Werribee lane, Werribee VIC", cinemaDesc: "Werribee Cinema-goers enjoy\n a complimentary ticket every\n 6 months. Sign up to the \nrewards program today!", moviesPlaying: ["Toy Story", "Frozen", "Star Trek: Into Darkness"]),
            Cinema(cinemaName: "Dandenong", cinemaAddress: "93 Dandenong Rd, Dandenong VIC", cinemaDesc: "Dandenong Cinemas have classic movie\n nights, so if you missed it the\n first time around, we\n will play it again!", moviesPlaying: ["Frozen", "Star Wars Episode V: The Empire Strikes Back"]),
            Cinema(cinemaName: "Box Hill", cinemaAddress: "82 Box Hill Rd, Box Hill VIC", cinemaDesc: "The classic Box Hill Cinemas\n are a Melbourne icon,\n being one of the first\n cinemas in Australia, since 1902.", moviesPlaying: ["The Terminator", "Star Trek: Into Darkness"]),
            Cinema(cinemaName: "Selby", cinemaAddress: "39 Selby Rd, Selby VIC", cinemaDesc: "Selby Cinemas are the most\n advanced cinemas in the world,\n featuring not only Real-D 3D\n technology, but prototype holographic\n technology for a more immersive experience!", moviesPlaying: ["Star Wars Episode V: The Empire Strikes Back", "The Terminator", "Toy Story"]),
            Cinema(cinemaName: "Frankston", cinemaAddress: "78 Frankston Rd, Frankston VIC", cinemaDesc: "Frankston Cinemas feature 9 Cinemas,\n the most out of any\n in Melbourne. Additionally,\n sell $8 tickets on Tueday\n afternoons for matinee sessions.", moviesPlaying: ["The Terminator", "Frozen", "Star Trek: Into Darkness"])

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
            
            return self.filteredCinemas.count
        }
        else {
            
            return self.cinemas.count
        }
        
        
    }
    
    //when user selects an item in tableview, perform segue
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("cinemaDetail", sender: tableView)
    }
    
    //segue to the next view controller, pushing all the information to it
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "cinemaDetail" {
            
            
            let cinemaDetails = segue.destinationViewController as! CinemaDetailViewController
            
            //if using the search bar
            if sender as! UITableView == self.searchDisplayController!.searchResultsTableView {
                
                let indexPath = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow()!
                let destinationTitle = self.filteredCinemas[indexPath.row].cinemaName
                let destinationDesc = self.filteredCinemas[indexPath.row].cinemaDesc
                let destinationAddress = self.filteredCinemas[indexPath.row].cinemaAddress
                let destinationCinemaInfo = self.filteredCinemas[indexPath.row].moviesPlaying
                cinemaDetails.title = destinationTitle
                cinemaDetails.cinemaDescText = destinationDesc
                cinemaDetails.cinemaAddressText = destinationAddress
                cinemaDetails.moviesPlaying = destinationCinemaInfo
                
                //play sound
                click.prepareToPlay()
                click.play()
                
                
            }
                //if not using the search bar
            else {
                
                let indexPath = self.tableView.indexPathForSelectedRow()!
                let destinationTitle = self.cinemas[indexPath.row].cinemaName
                let destinationDesc = self.cinemas[indexPath.row].cinemaDesc
                let destinationAddress = self.cinemas[indexPath.row].cinemaAddress
                let destinationCinemaInfo = self.cinemas[indexPath.row].moviesPlaying
                cinemaDetails.title = destinationTitle
                cinemaDetails.cinemaDescText = destinationDesc
                cinemaDetails.cinemaAddressText = destinationAddress
                cinemaDetails.moviesPlaying = destinationCinemaInfo
                

                //play sound
                click.prepareToPlay()
                click.play()
                
                
            }
            
        }
        
    }
    //back button
    @IBAction func backButton(sender: UIBarButtonItem) {
        
        click.prepareToPlay()
        click.play()
        self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    //function to populate cells of the TableView
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cinemaCell") as! UITableViewCell
        
        var cinema : Cinema
        //check to see if normal table or search results table is used, and set the object from the appropriate array.
        if tableView == self.searchDisplayController!.searchResultsTableView {
            cinema = filteredCinemas[indexPath.row]
            
        }
        else {
            // get the data from movies
            cinema = cinemas[indexPath.row]
        }
        
        //configure cell with name, and picture
        cell.textLabel!.text = cinema.cinemaName
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    //helper method for filtering
    func filterContentForSearchText(searchText : String, scope: String = "All"){
        
        self.filteredCinemas = self.cinemas.filter({ (cinema: Cinema) -> Bool in
            
            let stringMatch = cinema.cinemaName.rangeOfString(searchText)
            return (stringMatch != nil)
            
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

