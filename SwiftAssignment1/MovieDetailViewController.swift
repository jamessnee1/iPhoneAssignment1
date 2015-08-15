//
//  MovieDetailViewController.swift
//  SwiftAssignment1
//
//  Created by James Snee on 16/03/2015.
//  Copyright (c) 2015 James Snee and Heather Ingram. All rights reserved.
//

import UIKit
import AVFoundation

class MovieDetailViewController: UIViewController, UIPickerViewDelegate {
    
    //sound for buttons
    var click = AVAudioPlayer()

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet var movieRating: UILabel!
    @IBOutlet var playingLabel: UILabel!
    @IBOutlet weak var movieDescTextField: UITextView!
    @IBOutlet var bookMovieButton: UIButton!
    @IBOutlet var noOfTicketsLabel: UILabel!
    @IBOutlet var numticks: UILabel!
    @IBOutlet var moviePicker: UIPickerView!
    @IBOutlet var ticketsStepper: UIStepper!
    
    var movieDescText = String()
    var movieRatingText = String()
    var poster = UIImage()
    var movieTitle = String()
    //var cinemaAndTimes = ["Chadstone - 3:30pm-5:30pm", "Knox - 12:30pm-3:30pm", "Melbourne Central - 9:30am-11:30am"]
    var cinemaAndTimes = [String]()
    var cinemaTimes = [MovieTime]()
    
    //variables for picker view
    var itemSelected = String()
    var cinemaSelected = String()
    var timeSelected = [String]()
    
    //variable for number of tickets
    var currNumOfTickets = 1
    
    //function to convert movie cinemas and times to a string array for display in pickerview
    func convertCinemaAndTimeToString(movieTimes: [MovieTime]) -> [String] {
        
        var stringArray = [String]()
        
        for cinema in movieTimes {
            var cin = cinema.playingAtCinema
            var time = cinema.time
            var createdString = "\(cin), \(time)"
            //set the cinema and time to globals to display in booking information
            cinemaSelected = cinema.playingAtCinema
            timeSelected = cinema.time
            stringArray.append(createdString)
        
        }
        
        return stringArray
    }
    
    
    //pickerview methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        
        return cinemaAndTimes.count
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView) -> UIView! {
        
        //set picker view font and font size
        var pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.grayColor()
        pickerLabel.font = UIFont(name:"Helvetica", size: 10)
        pickerLabel.text = cinemaAndTimes[row]
        pickerLabel.textAlignment = NSTextAlignment.Center
        return pickerLabel
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        itemSelected = cinemaAndTimes[row]
        println("Current item: \(itemSelected)")
        //update the global cinema selected and time selected for booking information
        cinemaSelected = cinemaTimes[row].playingAtCinema
        timeSelected = cinemaTimes[row].time
        
    }
    
    //number of tickets
    @IBAction func noOfTicketsStepper(sender: UIStepper) {
        
        click.prepareToPlay()
        click.play()
        
        noOfTicketsLabel.text = Int(sender.value).description
        //assign the currNumOfTickets
        currNumOfTickets = Int(sender.value)
        println(currNumOfTickets)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sound URL
        var clickSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("click", ofType: "aif")!)
        click = AVAudioPlayer(contentsOfURL:clickSound, error: nil)

        cinemaAndTimes = convertCinemaAndTimeToString(cinemaTimes)
        
        //set initial pickerview item to first one in array
        itemSelected = cinemaAndTimes[0]

        //set initial number of tickets label
        self.noOfTicketsLabel.text = String(currNumOfTickets)
        
        //set background Color
        //self.view.backgroundColor = UIColor.blackColor()
        self.movieTitle = self.title!
        
        //set the label text from previous ViewController
        self.movieRating.text = movieRatingText
        self.movieDescTextField.text = movieDescText
        self.moviePoster.image = poster
        //alpha values for display elements is 0 to begin with, goes to 1
        moviePoster.alpha = 0.0
        movieDescTextField.alpha = 0.0
        movieRating.alpha = 0.0
        playingLabel.alpha = 0.0
        bookMovieButton.alpha = 0.0
        noOfTicketsLabel.alpha = 0.0
        numticks.alpha = 0.0
        moviePicker.alpha = 0.0
        ticketsStepper.alpha = 0.0
        
        
        UIView.animateWithDuration(1.0, animations: { ()->Void  in
            self.moviePoster.alpha = 1.0
            self.numticks.alpha = 1.0
        })
        
        UIView.animateWithDuration(1.5, animations: { ()->Void  in
            self.movieDescTextField.alpha = 1.0
            self.noOfTicketsLabel.alpha = 1.0
        })
        
        UIView.animateWithDuration(2.0, animations: { ()->Void  in
            self.movieRating.alpha = 1.0
            self.moviePicker.alpha = 1.0
        })
        
        UIView.animateWithDuration(2.5, animations: { ()->Void  in
            self.playingLabel.alpha = 1.0
            self.ticketsStepper.alpha = 1.0
        })
        
        UIView.animateWithDuration(3.0, animations: { ()->Void  in
            self.bookMovieButton.alpha = 1.0
        })

        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func bookMovie(sender: UIButton) {
        
        click.prepareToPlay()
        click.play()
        //create new dialog box with our information in it
        var booked = UIAlertController(title: "Booking", message: "Successfully booked movie with the following:\nMovie: \(movieTitle)\nCinema: \(cinemaSelected)\nTime: \(timeSelected)\nNumber of tickets: \(currNumOfTickets)", preferredStyle: UIAlertControllerStyle.Alert)
        booked.addAction(UIAlertAction(title:"OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(booked, animated: true, completion: nil)
        
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
